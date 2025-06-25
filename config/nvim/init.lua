require 'jim.core'
require 'jim.lazy'

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
