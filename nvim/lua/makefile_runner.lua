local M = {}

-- Find git root directory, or nil if not in a git repo
local function find_git_root()
  local current_dir = vim.fn.getcwd()
  local git_dir = vim.fn.finddir(".git", current_dir .. ";")
  if git_dir == "" then
    return nil
  end
  return vim.fn.fnamemodify(git_dir, ":h")
end

-- Find Makefile starting from current directory, traversing up to git root (if in git repo)
-- Returns: makefile_path, makefile_dir
local function find_makefile()
  local current_dir = vim.fn.getcwd()
  local git_root = find_git_root()
  local search_limit

  if git_root then
    -- In a git repo: search up to git root
    search_limit = git_root
  else
    -- Not in a git repo: only check current directory
    search_limit = current_dir
  end

  -- Start from current directory and traverse upward
  local dir = current_dir
  while true do
    local makefile = dir .. "/Makefile"
    if vim.fn.filereadable(makefile) == 1 then
      return makefile, dir
    end

    -- Stop if we've reached the search limit
    if dir == search_limit then
      break
    end

    -- Move up one directory
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      -- Reached filesystem root
      break
    end
    dir = parent
  end

  return nil, nil
end

-- Parse .PHONY targets from Makefile
-- Returns: list of { target = "test", description = "Run unit tests" }
local function parse_phony_targets(makefile_path)
  local file, err = io.open(makefile_path, "r")
  if not file then
    vim.notify("Failed to open Makefile: " .. (err or "unknown error"), vim.log.levels.ERROR)
    return {}
  end

  local content = file:read("*all")
  file:close()

  local targets = {}
  local phony_targets = {}

  -- First, find all .PHONY declarations
  for line in content:gmatch("[^\r\n]+") do
    local phony_line = line:match("^%.PHONY:%s*(.+)")
    if phony_line then
      -- Split by whitespace to get individual targets
      for target in phony_line:gmatch("%S+") do
        phony_targets[target] = true
      end
    end
  end

  -- Now find each phony target's definition and associated comment
  local lines = {}
  for line in content:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  for i, line in ipairs(lines) do
    -- Check if this line defines a target (target: dependencies)
    local target_name = line:match("^([%w_-]+):")
    if target_name and phony_targets[target_name] then
      local description = ""

      -- Check for inline comment on the same line
      local inline_comment = line:match("#%s*(.+)")
      if inline_comment then
        description = inline_comment
      else
        -- Check for comment on the previous line
        if i > 1 then
          local prev_line = lines[i - 1]
          local prev_comment = prev_line:match("^%s*#%s*(.+)")
          if prev_comment then
            description = prev_comment
          end
        end
      end

      table.insert(targets, {
        target = target_name,
        description = description,
      })
    end
  end

  return targets
end

-- Show success message in command bar
local function show_success(target)
  vim.notify("make " .. target .. " succeeded!", vim.log.levels.INFO)
end

-- Show failure output in a split buffer
local function show_failure(target, output)
  -- Create a new buffer
  local bufnr = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })

  -- Filter out empty lines at the end
  while #output > 0 and output[#output] == "" do
    table.remove(output)
  end

  -- Set buffer content
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)

  -- Create a horizontal split at the bottom
  vim.cmd("botright 5split")
  local winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(winnr, bufnr)

  -- Set buffer name
  vim.api.nvim_buf_set_name(bufnr, "[Make Error: " .. target .. "]")

  -- Make buffer closeable with 'q'
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = bufnr, silent = true })

  -- Set buffer as non-modifiable
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
end

-- Run make target asynchronously
local function run_target(target, makefile_dir)
  local output = {}

  vim.fn.jobstart({ "make", target }, {
    cwd = makefile_dir,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          show_success(target)
        else
          show_failure(target, output)
        end
      end)
    end,
  })
end

-- Main function: Open Telescope picker with make targets
function M.pick_and_run()
  local makefile_path, makefile_dir = find_makefile()

  if not makefile_path then
    vim.notify("no Makefile found", vim.log.levels.WARN)
    return
  end

  local targets = parse_phony_targets(makefile_path)

  if #targets == 0 then
    vim.notify("no .PHONY targets found in Makefile", vim.log.levels.WARN)
    return
  end

  -- Create Telescope picker
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "Make Targets",
      finder = finders.new_table({
        results = targets,
        entry_maker = function(entry)
          local display = entry.target
          if entry.description ~= "" then
            display = display .. " - " .. entry.description
          end
          return {
            value = entry.target,
            display = display,
            ordinal = entry.target .. " " .. entry.description,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          run_target(selection.value, makefile_dir)
        end)
        return true
      end,
    })
    :find()
end

return M
