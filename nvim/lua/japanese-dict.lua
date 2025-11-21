-- Japanese dictionary lookup plugin
-- Provides popup dictionary definitions for Japanese words

local M = {}

-- Path to the dictionary file
local dict_path = vim.fn.stdpath("data") .. "/dictionaries/jmdict-eng-common-3.6.1.json"
local dict_data = nil
local dict_index = {} -- Index for faster lookups
local MAX_ENTRIES = 3 -- Maximum number of entries to show in popup

-- Load and index the dictionary
local function load_dictionary()
  if dict_data then
    return true
  end

  local file = io.open(dict_path, "r")
  if not file then
    vim.notify("Japanese dictionary not found at: " .. dict_path, vim.log.levels.ERROR)
    return false
  end

  local content = file:read("*all")
  file:close()

  local ok, parsed = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Failed to parse dictionary JSON: " .. tostring(parsed), vim.log.levels.ERROR)
    return false
  end

  dict_data = parsed

  -- Build index for faster lookups
  if dict_data.words then
    for _, entry in ipairs(dict_data.words) do
      -- Index by kanji
      if entry.kanji then
        for _, k in ipairs(entry.kanji) do
          if not dict_index[k.text] then
            dict_index[k.text] = {}
          end
          table.insert(dict_index[k.text], entry)
        end
      end

      -- Index by kana
      if entry.kana then
        for _, k in ipairs(entry.kana) do
          if not dict_index[k.text] then
            dict_index[k.text] = {}
          end
          table.insert(dict_index[k.text], entry)
        end
      end
    end
  end

  vim.notify("Dictionary loaded with " .. #dict_data.words .. " entries", vim.log.levels.INFO)
  return true
end

-- Look up a word in the dictionary
local function lookup_word(word)
  if not dict_data then
    if not load_dictionary() then
      return nil
    end
  end

  return dict_index[word]
end

-- Query Jisho.org API as fallback
local function lookup_online(word)
  -- URL encode the word
  local encoded_word = word:gsub("([^%w%.%- ])", function(c)
    return string.format("%%%02X", string.byte(c))
  end):gsub(" ", "+")

  local url = string.format("https://jisho.org/api/v1/search/words?keyword=%s", encoded_word)

  -- Use curl to fetch results
  local handle = io.popen(string.format("curl -s '%s' 2>/dev/null", url))
  if not handle then
    return nil
  end

  local result = handle:read("*all")
  handle:close()

  if not result or result == "" then
    return nil
  end

  -- Parse JSON response
  local ok, parsed = pcall(vim.json.decode, result)
  if not ok or not parsed or not parsed.data then
    return nil
  end

  -- Convert Jisho format to our internal format
  local entries = {}
  for _, item in ipairs(parsed.data) do
    local entry = {
      kanji = {},
      kana = {},
      sense = {}
    }

    -- Extract kanji forms
    if item.japanese then
      for _, jp in ipairs(item.japanese) do
        if jp.word then
          table.insert(entry.kanji, { text = jp.word })
        end
        if jp.reading then
          table.insert(entry.kana, { text = jp.reading })
        end
      end
    end

    -- Extract definitions
    if item.senses then
      for _, sense in ipairs(item.senses) do
        local new_sense = {
          partOfSpeech = sense.parts_of_speech or {},
          gloss = {}
        }

        if sense.english_definitions then
          for _, def in ipairs(sense.english_definitions) do
            table.insert(new_sense.gloss, { text = def, lang = "eng" })
          end
        end

        table.insert(entry.sense, new_sense)
      end
    end

    table.insert(entries, entry)
  end

  return #entries > 0 and entries or nil
end

-- Look up word with online fallback
local function lookup_word_with_fallback(word)
  -- Try local dictionary first
  local entries = lookup_word(word)

  -- If not found locally, try online
  if not entries or #entries == 0 then
    entries = lookup_online(word)
    if entries then
      -- Add marker that these are online results
      for _, entry in ipairs(entries) do
        entry._online = true
      end
    end
  end

  return entries
end

-- Format a dictionary entry for display
local function format_entry(entry)
  local lines = {}

  -- Word forms (kanji and kana)
  local forms = {}
  if entry.kanji and #entry.kanji > 0 then
    for _, k in ipairs(entry.kanji) do
      table.insert(forms, k.text)
    end
  end

  local readings = {}
  if entry.kana and #entry.kana > 0 then
    for _, k in ipairs(entry.kana) do
      table.insert(readings, k.text)
    end
  end

  -- Build header line
  if #forms > 0 then
    table.insert(lines, "【" .. table.concat(forms, "・") .. "】")
    if #readings > 0 then
      table.insert(lines, "  " .. table.concat(readings, "、"))
    end
  elseif #readings > 0 then
    table.insert(lines, "【" .. table.concat(readings, "・") .. "】")
  end

  table.insert(lines, "")

  -- Senses (definitions)
  if entry.sense then
    for i, sense in ipairs(entry.sense) do
      -- Part of speech
      if sense.partOfSpeech and #sense.partOfSpeech > 0 then
        table.insert(lines, "  (" .. table.concat(sense.partOfSpeech, ", ") .. ")")
      end

      -- Glosses
      if sense.gloss then
        for j, gloss in ipairs(sense.gloss) do
          if gloss.lang == "eng" then
            local prefix = "  " .. i .. ". "
            if j > 1 then
              prefix = "     "
            end
            table.insert(lines, prefix .. gloss.text)
          end
        end
      end

      if i < #entry.sense then
        table.insert(lines, "")
      end
    end
  end

  return lines
end

-- Format multiple entries for display
local function format_results(entries, search_term, show_all)
  if not entries or #entries == 0 then
    return { "No definition found for: " .. search_term }, false
  end

  local lines = {}
  local has_more = false

  for i, entry in ipairs(entries) do
    if not show_all and i > MAX_ENTRIES then
      table.insert(lines, "")
      table.insert(lines, "... (" .. (#entries - MAX_ENTRIES) .. " more entries)")
      table.insert(lines, "Press <Enter> to show all entries")
      has_more = true
      break
    end

    if i > 1 then
      table.insert(lines, "")
      table.insert(lines, string.rep("─", 40))
      table.insert(lines, "")
    end

    local entry_lines = format_entry(entry)
    for _, line in ipairs(entry_lines) do
      table.insert(lines, line)
    end
  end

  return lines, has_more
end

-- Show popup with dictionary definition
function M.show_definition(word, show_all)
  if not word or word == "" then
    vim.notify("No word selected", vim.log.levels.WARN)
    return
  end

  -- Trim whitespace
  word = vim.trim(word)

  local entries = lookup_word_with_fallback(word)
  local lines, has_more = format_results(entries, word, show_all)

  -- Check if results are from online
  local is_online = entries and #entries > 0 and entries[1]._online

  -- Create floating window
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  -- Set buffer options
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = "markdown"

  -- Calculate window size
  local width = 60
  local height = math.min(#lines, 20)

  -- Get cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1] - 1 -- Convert to 0-indexed
  local cursor_col = cursor_pos[2]

  -- Get editor dimensions
  local ui = vim.api.nvim_list_uis()[1]
  if not ui then
    vim.notify("No UI available", vim.log.levels.ERROR)
    return
  end
  local win_width = ui.width
  local win_height = ui.height

  -- Calculate position near cursor, with preference to show below and to the right
  -- Add offset to avoid covering the selected text
  local row_offset = 1
  local col_offset = 2

  local row = cursor_row + row_offset
  local col = cursor_col + col_offset

  -- Adjust if popup would go off screen
  if row + height > win_height then
    -- Show above cursor instead
    row = cursor_row - height - 1
    if row < 0 then
      -- If it doesn't fit above either, center vertically
      row = math.floor((win_height - height) / 2)
    end
  end

  if col + width > win_width then
    -- Shift left to fit on screen
    col = win_width - width - 1
    if col < 0 then
      col = 0
    end
  end

  -- Window options
  local title = is_online and " Japanese Dictionary (Online) " or " Japanese Dictionary "
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
  }

  local winnr = vim.api.nvim_open_win(bufnr, true, opts)

  -- Set window options
  vim.wo[winnr].wrap = true
  vim.wo[winnr].linebreak = true

  -- Close popup function
  local close_popup = function()
    if vim.api.nvim_win_is_valid(winnr) then
      vim.api.nvim_win_close(winnr, true)
    end
  end

  -- Add keymaps to close popup
  local opts_map = { buffer = bufnr, noremap = true, silent = true, nowait = true }
  vim.keymap.set("n", "q", close_popup, opts_map)
  vim.keymap.set("n", "<Esc>", close_popup, opts_map)

  -- Add keymap to expand all entries if there are more
  if has_more then
    vim.keymap.set("n", "<CR>", function()
      close_popup()
      M.show_definition(word, true)
    end, opts_map)
  end

  -- Auto-close when leaving the popup window
  local augroup = vim.api.nvim_create_augroup("JapaneseDictPopup", { clear = true })
  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      close_popup()
      vim.api.nvim_clear_autocmds({ group = augroup })
    end,
  })
end

-- Get visually selected text
local function get_visual_selection()
  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  -- Check if marks are valid
  if start_line == 0 or end_line == 0 then
    return nil
  end

  -- Get the lines
  local lines = vim.fn.getline(start_line, end_line)

  -- Check if lines is valid
  if not lines or (type(lines) == "table" and #lines == 0) then
    return nil
  end

  -- If lines is a string, convert to table
  if type(lines) == "string" then
    lines = {lines}
  end

  -- Handle single line selection
  if #lines == 1 then
    -- Use vim.str_utfindex to properly handle UTF-8 character boundaries
    local line = lines[1]
    -- Convert byte positions to character positions
    local start_idx = vim.str_utfindex(line, start_col - 1)
    local end_idx = vim.str_utfindex(line, end_col)
    -- Extract substring using character positions
    local char_count = end_idx - start_idx
    return vim.fn.strcharpart(line, start_idx, char_count)
  end

  -- Handle multi-line selection (just use first line for now)
  local line = lines[1]
  local start_idx = vim.str_utfindex(line, start_col - 1)
  return vim.fn.strcharpart(line, start_idx)
end

-- Command to look up selected text
function M.lookup_selection()
  local word = get_visual_selection()
  if not word or word == "" then
    vim.notify("No text selected or selection is empty", vim.log.levels.WARN)
    return
  end
  M.show_definition(word)
end

-- Setup function
function M.setup()
  -- Create user command
  vim.api.nvim_create_user_command("JaDict", function(opts)
    local word = opts.args
    if word == "" then
      word = vim.fn.expand("<cword>")
    end
    M.show_definition(word)
  end, { nargs = "?", desc = "Look up Japanese word in dictionary" })

  -- Preload dictionary in the background (optional, for faster first lookup)
  vim.defer_fn(function()
    load_dictionary()
  end, 1000)
end

return M
