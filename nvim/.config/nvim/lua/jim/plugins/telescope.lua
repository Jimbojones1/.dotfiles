return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'
    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local action_state = require 'telescope.actions.state'
    local Path = require 'plenary.path'
    local scandir = require 'plenary.scandir'

    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    }

    ------------------------------------------------------------------
    local function smart_find_files()
      local cwd = vim.fn.getcwd()
      local dot_root = vim.fn.expand '~/.dotfiles' -- adjust if you use $DOTFILES

      local opts = {}
      if cwd:sub(1, #dot_root) == dot_root then
        opts.hidden = true -- show dot-files
      end
      builtin.find_files(opts)
    end

    local function open_stow_dir()
      local dot_root = vim.fn.expand '~/.dotfiles'
      local dirs = scandir.scan_dir(dot_root, { depth = 1, add_dirs = true, only_dirs = true })

      pickers
        .new({}, {
          prompt_title = 'Stow packages',
          finder = finders.new_table {
            results = dirs,
            entry_maker = function(p)
              return {
                value = p,
                display = Path:new(p):make_relative(dot_root), -- just “git”, …
                ordinal = p,
              }
            end,
          },
          sorter = require('telescope.config').values.generic_sorter {},
          attach_mappings = function(_, _)
            actions.select_default:replace(function(bufnr)
              local entry = action_state.get_selected_entry(bufnr)
              actions.close(bufnr)
              if entry then
                require('telescope.builtin').find_files {
                  cwd = entry.value,
                  hidden = true,
                }
              end
            end)
            return true
          end,
        })
        :find()
    end

    -- set keymaps

    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>ff', smart_find_files, { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
    keymap.set('n', '<leader>fd', open_stow_dir, { desc = 'Open stow package (dotfiles)' })
  end,
}
