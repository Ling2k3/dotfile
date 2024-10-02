local vim = vim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local colorscheme = "moonfly"
vim.cmd("colorscheme " .. colorscheme)

require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({
   opts = {
      enable_autoclose = true,
      enable_autorename = true,
      enable_close_on_slash = false,
   },
})

require("bufferline").setup({
   options = {
      separator_style = "padded_slope",
   },
})

require("lightspeed").setup({
   ignore_case = false,
   exit_after_idle_msecs = { unlabeled = nil, labeled = nil },
   --- s/x ---
   jump_to_unique_chars = { safety_timeout = 400 },
   match_only_the_start_of_same_char_seqs = true,
   force_beacons_into_match_width = false,
   -- Display characters in a custom way in the highlighted matches.
   substitute_chars = { ["\r"] = "¬" },
   -- Leaving the appropriate list empty effectively disables "smart" mode,
   -- and forces auto-jump to be on or off.
   safe_labels = { ... },
   labels = { ... },
   -- These keys are captured directly by the plugin at runtime.
   special_keys = {
      next_match_group = "<space>",
      prev_match_group = "<tab>",
   },
   --- f/t ---
   limit_ft_matches = 4,
   repeat_ft_with_target_char = false,
})

require("neo-tree").setup({
   close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
   popup_border_style = "rounded",
   enable_git_status = true,
   enable_diagnostics = true,
   open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
   sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
   sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
   -- sort_function = function (a,b)
   --       if a.type == b.type then
   --           return a.path > b.path
   --       else
   --           return a.type > b.type
   --       end
   --   end , -- this sorts files and directories descendantly
   default_component_configs = {
      container = {
         enable_character_fade = true,
      },
      indent = {
         indent_size = 2,
         padding = 1, -- extra padding on left hand side
         -- indent guides
         with_markers = true,
         indent_marker = "│",
         last_indent_marker = "└",
         highlight = "NeoTreeIndentMarker",
         -- expander config, needed for nesting files
         with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
         expander_collapsed = "",
         expander_expanded = "",
         expander_highlight = "NeoTreeExpander",
      },
      icon = {
         folder_closed = "",
         folder_open = "",
         folder_empty = "󰜌",
         -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
         -- then these will never be used.
         default = "*",
         highlight = "NeoTreeFileIcon",
      },
      modified = {
         symbol = "[+]",
         highlight = "NeoTreeModified",
      },
      name = {
         trailing_slash = false,
         use_git_status_colors = true,
         highlight = "NeoTreeFileName",
      },
      git_status = {
         symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
         },
      },
      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
      file_size = {
         enabled = true,
         required_width = 64, -- min width of window required to show this column
      },
      type = {
         enabled = true,
         required_width = 122, -- min width of window required to show this column
      },
      last_modified = {
         enabled = true,
         required_width = 88, -- min width of window required to show this column
      },
      created = {
         enabled = true,
         required_width = 110, -- min width of window required to show this column
      },
      symlink_target = {
         enabled = false,
      },
   },
   -- A list of functions, each representing a global custom command
   -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
   -- see `:h neo-tree-custom-commands-global`
   commands = {},
   window = {
      position = "left",
      width = 40,
      mapping_options = {
         noremap = true,
         nowait = true,
      },
      mappings = {
         ["<space>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
         },
         ["<2-LeftMouse>"] = "open",
         ["<cr>"] = "open",
         ["<esc>"] = "cancel", -- close preview or floating neo-tree window
         ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
         -- Read `# Preview Mode` for more information
         ["l"] = "focus_preview",
         ["S"] = "open_split",
         ["s"] = "open_vsplit",
         -- ["S"] = "split_with_window_picker",
         -- ["s"] = "vsplit_with_window_picker",
         ["t"] = "open_tabnew",
         -- ["<cr>"] = "open_drop",
         -- ["t"] = "open_tab_drop",
         ["w"] = "open_with_window_picker",
         --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
         ["C"] = "close_node",
         -- ['C'] = 'close_all_subnodes',
         ["z"] = "close_all_nodes",
         --["Z"] = "expand_all_nodes",
         ["a"] = {
            "add",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
               show_path = "none", -- "none", "relative", "absolute"
            },
         },
         ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
         ["d"] = "delete",
         ["r"] = "rename",
         ["y"] = "copy_to_clipboard",
         ["x"] = "cut_to_clipboard",
         ["p"] = "paste_from_clipboard",
         ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
         -- ["c"] = {
         --  "copy",
         --  config = {
         --    show_path = "none" -- "none", "relative", "absolute"
         --  }
         --}
         ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
         ["q"] = "close_window",
         ["R"] = "refresh",
         ["?"] = "show_help",
         ["<"] = "prev_source",
         [">"] = "next_source",
         ["i"] = "show_file_details",
      },
   },
   nesting_rules = {},
   filesystem = {
      filtered_items = {
         visible = true, -- when true, they will just be displayed differently than normal items
         hide_dotfiles = false,
         hide_gitignored = false,
         hide_hidden = false, -- only works on Windows for hidden files/directories
         hide_by_name = {
            --"node_modules"
         },
         hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
         },
         always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
         },
         always_show_by_pattern = { -- uses glob style patterns
            --".env*",
         },
         never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
         },
         never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
         },
      },
      follow_current_file = {
         enabled = true,                      -- This will find and focus the file in the active buffer every time
         --               -- the current file is changed while the tree is open.
         leave_dirs_open = false,             -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = false,               -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      ---- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      window = {
         mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["og"] = { "order_by_git_status", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
            -- ['<key>'] = function(state) ... end,
         },
         fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
            -- ['<key>'] = function(state, scroll_padding) ... end,
         },
      },

      commands = {}, -- Add a custom command or override a global one using the same function name
   },
   buffers = {
      follow_current_file = {
         enabled = true,          -- This will find and focus the file in the active buffer every time
         --              -- the current file is changed while the tree is open.
         leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true,    -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
         mappings = {
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
         },
      },
   },
   git_status = {
      window = {
         position = "float",
         mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
            ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
         },
      },
   },
})

require("transparent").clear_prefix("Bufferline")
require("transparent").clear_prefix("toggleterm")
require("transparent").clear_prefix("lualine")
require("transparent").clear_prefix("NeoTree")

require('diagflow').setup({
   enable = true, max_width = 60,     -- The maximum width of the diagnostic messages
   max_height = 10,    -- the maximum height per diagnostics
   severity_colors = { -- The highlight groups to use for each diagnostic severity level
      error = "DiagnosticFloatingError",
      warning = "DiagnosticFloatingWarn",
      info = "DiagnosticFloatingInfo",
      hint = "DiagnosticFloatingHint",
   },
   format = function(diagnostic)
      return diagnostic.message
   end,
   gap_size = 1,
   scope = 'cursor', -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
   padding_top = 0,
   padding_right = 0,
   text_align = 'right',                                  -- 'left', 'right'
   placement = 'top',                                     -- 'top', 'inline'
   inline_padding_left = 0,                               -- the padding left when the placement is inline
   update_event = { 'DiagnosticChanged', 'BufReadPost' }, -- the event that updates the diagnostics cache
   toggle_event = {},                                     -- if InsertEnter, can toggle the diagnostics on inserts
   show_sign = false,                                     -- set to true if you want to render the diagnostic sign before the diagnostic message
   render_event = { 'DiagnosticChanged', 'CursorMoved' },
   border_chars = {
      top_left = "┌",
      top_right = "┐",
      bottom_left = "└",
      bottom_right = "┘",
      horizontal = "─",
      vertical = "│"
   },
   show_borders = false,
})

require("null-ls").setup {}
