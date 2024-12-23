------------------------
--- General settings ---
------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.rnu = true

-- The main source for editor configuration is a .editorconfig file, but the settings below are sensible defaults.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.nvim/undodir") -- vim doesn't parse ~ as a path when used in a string.
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

----------------------
--- Shell settings ---
----------------------
if vim.fn.executable('pwsh') == 1 then
  vim.o.shell = 'pwsh'
else
  vim.o.shell = 'powershell'
end

vim.o.shellcmdflag =
'-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'

vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''

--------------------
--- LSP settings ---
--------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Info = " ", Hint = "󰌶 " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

----------------------
--- Other settings ---
----------------------

-- Show short highlight when yanking
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]])

-- Workaround for Shada files not being cleared:
vim.cmd("autocmd VimLeavePre * ClearShada")
