require 'jim.core'
require 'jim.lazy'

do
  local orig = vim.lsp.util.open_floating_preview

  ---@diagnostic disable-next-line: duplicate-set-field
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    opts.max_width = opts.max_width or 100
    return orig(contents, syntax, opts, ...)
  end
end
-- ------
-- helper to pick up ./venv/bin/python if it exists
local function detect_venv_python()
  local cwd = vim.fn.getcwd()
  local venv_py = cwd .. '/venv/bin/python'
  if vim.fn.executable(venv_py) == 1 then
    return venv_py
  end
  -- fall back to whatever Python is in PATH
  return vim.fn.exepath 'python3' or vim.fn.exepath 'python'
end

-- Set it once on startup
vim.g.python3_host_prog = detect_venv_python()

-- Update it whenever you change directories
vim.api.nvim_create_autocmd({ 'DirChanged', 'VimEnter' }, {
  callback = function()
    vim.g.python3_host_prog = detect_venv_python()
  end,
})
