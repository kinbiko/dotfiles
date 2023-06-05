local cmp = require('cmp')
local lightspeed = require('lightspeed')
local lualine = require('lualine')
local luasnip = require('luasnip')
local numb = require('numb')
local nvim_tree = require('nvim-tree')
local twilight = require("twilight")

require("luasnip.loaders.from_snipmate").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local tab_forward = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

local tab_backward = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = {
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping(tab_forward, { 'i', 's', 'c' }),
    ["<Tab>"] = cmp.mapping(tab_forward, { 'i', 's', }),
    ["<S-Tab>"] = cmp.mapping(tab_backward, { 'i', 's', }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  }
})

lightspeed.setup({
  ignore_case = true,
  exit_after_idle_msecs = { -- Keep waiting for my slow fingers.
    labeled = nil,
    unlabeled = nil,
  },
  jump_to_unique_chars = false,
})

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'branch', 'diff', 'diagnostics'},
    lualine_b = {},
    lualine_c = {'filename', 'filetype'},
    lualine_x = {'progress'},
    lualine_y = {'location'},
    lualine_z = {'mode'}
  }
})

numb.setup()

-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local function on_attach_nvim_tree(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<S-CR>', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'u', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'x', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Space>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'hg', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'hd', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'hh', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'n', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'yy', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'yn', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'yr', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'ya', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '[', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', ']', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '(', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ')', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'X', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 's', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  -- Unmapped bindings, and their default value:
  -- vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  -- vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  -- vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  -- vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  -- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  -- vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  -- vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  -- vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  -- vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  -- vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  -- vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  -- vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  -- vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  -- vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  -- vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  -- vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  -- vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
end

nvim_tree.setup({ -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = true,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  open_on_tab = false,
  ignore_buf_on_tab_change = {},
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = on_attach_nvim_tree,
  remove_keymaps = false, -- boolean (disable totally or not) or list of key (lhs)
  view = {
    adaptive_size = false,
    centralize_selection = true,
    width = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false, -- This feature is actually kind a cool, but gives an error 50% of the time.
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 10,
        row = 10,
        col = 40,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = true,
    highlight_git = false,
    full_name = true, -- floats the whole name if it doesn't fit in the nvim-tree window.
    highlight_opened_files = "all",
    root_folder_modifier = ":~",
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "go.mod", "go.sum" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
}) -- END_DEFAULT_OPTS
-- Make NvimTree's window transparent
vim.api.nvim_set_hl(0, "NvimTreeNormal", {bg = 'none'})
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", {bg = 'none'})

vim.api.nvim_set_keymap('n', '<localleader><localleader>', '<cmd>NvimTreeToggle<cr>', {noremap = true, silent = true}) -- Open/close file browser
vim.api.nvim_set_keymap('n', '<localleader>f', '<cmd>NvimTreeFindFileToggle<cr>', {noremap = true, silent = true}) -- Find the current file in file browser

twilight.setup({
  dimming = {
    alpha = 0.25, -- amount of dimming
    inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 3 -- amount of lines we will try to show around the current line
})

-- Format terraform files whenever I save
vim.g.terraform_fmt_on_save = 1

-- Don't exit tmux zoom mode if attempting to navigate out of vim
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Ensure that I can enter markdown checkboxes without generating a double
-- space like this: [  ]. (should only have a single space inside when hitting
-- space)
vim.g.lexima_enable_space_rules = 0

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "help", "c", "go", "javascript", "markdown", "typescript", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
