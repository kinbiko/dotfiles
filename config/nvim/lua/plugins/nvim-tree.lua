local function on_attach_nvim_tree(bufnr)
  local api = require("nvim-tree.api")

  local map = function(lhs, rhs, description)
    vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = description })
  end

  map("<CR>", api.node.open.edit, "Open")
  map("<S-CR>", api.node.open.no_window_picker, "Open: No Window Picker")
  map("C", api.tree.change_root_to_node, "CD")
  map("|", api.node.open.vertical, "Open: Vertical Split")
  map("-", api.node.open.horizontal, "Open: Horizontal Split")
  map("u", api.node.navigate.parent, "Parent Directory")
  map("x", api.node.navigate.parent_close, "Close Directory")
  map("<Space>", api.node.open.preview, "Open Preview")
  map("hg", api.tree.toggle_gitignore_filter, "Toggle Git Ignore")
  map("hd", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
  map("hh", api.tree.toggle_custom_filter, "Toggle Hidden")
  map("R", api.tree.reload, "Refresh")
  map("n", api.fs.create, "Create")
  map("d", api.fs.remove, "Delete")
  map("r", api.fs.rename, "Rename")
  map("x", api.fs.cut, "Cut")
  map("yy", api.fs.copy.node, "Copy")
  map("p", api.fs.paste, "Paste")
  map("yn", api.fs.copy.filename, "Copy Name")
  map("yr", api.fs.copy.relative_path, "Copy Relative Path")
  map("ya", api.fs.copy.absolute_path, "Copy Absolute Path")
  map("[", api.node.navigate.diagnostics.prev, "Prev Diagnostic")
  map("]", api.node.navigate.diagnostics.next, "Next Diagnostic")
  map("(", api.node.navigate.git.prev, "Prev Git")
  map(")", api.node.navigate.git.next, "Next Git")
  map("q", api.tree.close, "Close")
  map("X", api.tree.collapse_all, "Collapse")
  map("E", api.tree.expand_all, "Expand All")
  map("s", api.tree.search_node, "Search")
  map("<C-k>", api.node.show_info_popup, "Info")
  map("?", api.tree.toggle_help, "Help")
  -- Unmapped bindings, and their default value:
  -- map('-', api.tree.change_root_to_parent, 'Up')
  -- map('D', api.fs.trash, 'Trash')
  -- map('o', api.node.open.edit, 'Open')
  -- map('<2-LeftMouse>', api.node.open.edit, 'Open')
  -- map('<C-e>', api.node.open.replace_tree_buffer, 'Open: In Place')
  -- map('<C-t>', api.node.open.tab, 'Open: New Tab')
  -- map('<', api.node.navigate.sibling.prev, 'Previous Sibling')
  -- map('>', api.node.navigate.sibling.next, 'Next Sibling')
  -- map('K', api.node.navigate.sibling.first, 'First Sibling')
  -- map('J', api.node.navigate.sibling.last, 'Last Sibling')
  -- map('<C-r>', api.fs.rename_sub, 'Rename: Omit Filename')
  -- map('s', api.node.run.system, 'Run System')
  -- map('f', api.live_filter.start, 'Filter')
  -- map('F', api.live_filter.clear, 'Clean Filter')
  -- map('.', api.node.run.cmd, 'Run Command')
  -- map('m', api.marks.toggle, 'Toggle Bookmark')
  -- map('bmv', api.marks.bulk.move, 'Move Bookmarked')
end

return {
  {
    "kyazdani42/nvim-tree.lua",
    keys = {
      { "<localleader><localleader>", "<cmd>NvimTreeToggle<cr>" },
      { "<localleader>f", "<cmd>NvimTreeFindFileToggle<cr>" },
    },
    config = function()
      require("nvim-tree").setup({
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
      })
    end,
  },
}
