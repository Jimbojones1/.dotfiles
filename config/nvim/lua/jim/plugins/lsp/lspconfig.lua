return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim', opts = {} },
    'williamboman/mason.nvim', -- Mason installer
    'williamboman/mason-lspconfig.nvim', -- Mason-LSPConfig bridge
  },
  config = function()
    -- Import plugins
    local lspconfig = require 'lspconfig'
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local keymap = vim.keymap

    -- Keymaps on LspAttach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
        keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
        keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
        keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
        keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
      end,
    })

    -- Configure diagnostics signs
    vim.diagnostic.config {
      signs = {
        Error = { text = ' ', texthl = 'DiagnosticSignError' },
        Warn = { text = ' ', texthl = 'DiagnosticSignWarn' },
        Hint = { text = '󰠠 ', texthl = 'DiagnosticSignHint' },
        Info = { text = ' ', texthl = 'DiagnosticSignInfo' },
      },
    }
    -- Capabilities for completion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup Mason
    mason.setup()
    mason_lspconfig.setup {
      ensure_installed = { 'gopls', 'graphql', 'emmet_ls', 'lua_ls', 'pyright', 'ts_ls' },
      automatic_installation = true,
      automatic_setup = true,
    }

    -- Use new Neovim API to configure servers
    -- Go
    vim.lsp.config('gopls', {
      capabilities = capabilities,
      settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true, gofumpt = true } },
    })
    -- GraphQL
    vim.lsp.config('graphql', {
      capabilities = capabilities,
      filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
    })
    -- Emmet
    vim.lsp.config('emmet_ls', {
      capabilities = capabilities,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
    })
    -- Lua (Neovim)
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = { Lua = { diagnostics = { globals = { 'vim' } }, completion = { callSnippet = 'Replace' } } },
    })
    -- Python (Pyright)
    vim.lsp.config('pyright', {
      capabilities = capabilities,
      settings = { python = { analysis = { autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true } } },
    })
    -- Node/TypeScript (tsserver)
    vim.lsp.config('tsserver', {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })
  end,
}
