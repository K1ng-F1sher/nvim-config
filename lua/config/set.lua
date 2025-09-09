----------------------
--- General settings ---
------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.nvim/undodir") -- vim doesn't parse ~ as a path when used in a string.
vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "150"
vim.o.winborder = "rounded"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

----------------------
--- Shell settings ---
----------------------
if string.find(string.lower(vim.loop.os_uname().sysname), 'windows') then
  if vim.fn.executable('pwsh') == 1 then
    vim.o.shell = 'pwsh'
  else
    vim.o.shell = 'powershell'
  end

  -- Code below was removed to make xml formatting work
  -- vim.o.shellcmdflag =
  -- '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'
  -- vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
  -- vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'

  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
  vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
  vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"
end

--------------------
--- LSP settings ---
--------------------
vim.diagnostic.config({
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌶',
    }
  },
  undercurl = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  update_in_insert = false, -- false so diags are updated on InsertLeave
  virtual_text = { current_line = false, severity = { min = "WARN" } },
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    source = true,
    header = nil
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = 'expr'
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
vim.api.nvim_create_autocmd('LspDetach', { command = 'setl foldexpr<' })

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

----------------------
--- Style settings ---
----------------------

-- Show short highlight when yanking
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]])

-- Shift numbered registers up (1 becomes 2, etc.)
local function yank_shift()
  for i = 9, 1, -1 do
    vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
  end
end

-- Create autocmd for TextYankPost event
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local event = vim.v.event
    if event.operator == "y" then
      yank_shift()
    end
  end,
})

-- Set highlighting styles for quickscope
vim.cmd([[
  highlight QuickScopePrimary gui=underline cterm=underline
  highlight QuickScopeSecondary gui=italic cterm=italic
]])

-- Enable word wrap in markdown files.
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = { '*.md' },
  callback = function()
    vim.opt.wrap = true
    Map({ "n", "o", "x" }, "j", "gj", {})
    Map({ "n", "o", "x" }, "k", "gk", {})
    Map({ "n", "o", "x" }, "H", "g0", {})
    Map({ "n", "o", "x" }, "L", "g$", {})
  end,
})

-- Disable word wrap outside of markdown files.
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = { '*.md' },
  callback = function()
    vim.opt.wrap = false
    Map({ "n", "o", "x" }, "j", "j", {})
    Map({ "n", "o", "x" }, "k", "k", {})
    Map({ "n", "o", "x" }, "H", "0", {})
    Map({ "n", "o", "x" }, "L", "$", {})
  end,
})

-------------------
--- Workarounds ---
-------------------

-- Workaround for Shada files not being cleared:
vim.cmd("autocmd VimLeavePre * ClearShada")

-- Always open paths relative to the cwd [source]()https://github.com/neovim/neovim/issues/8587#issuecomment-2576033560
---@param bufnr number
local open_file_buf_relative_path = function(bufnr)
  local bufname = vim.fn.bufname(bufnr)
  -- if bufname starts with c: or ~ then its a full path and want to open relative
  if bufname:sub(1, 2):lower() == 'c:' or bufname:sub(1, 1) == '~' then
    local cwd = vim.uv.cwd() or '.'
    local root = vim.fs.normalize(vim.uv.fs_realpath(cwd) or '.') .. '/'
    local norm_path = vim.fs.normalize(vim.uv.fs_realpath(bufname) or bufname)
    if norm_path:find(root, 1, true) ~= 1 then
      -- NOTE: not changing if not part of root path (cwd)
      root = ''
    end
    if root == '' or root == nil then
      return
    end
    local relative_path = norm_path:sub(#root + 1)
    vim.schedule(function()
      vim.notify('Setting buffer name to relative path: ' ..
        relative_path .. ' for bufnr: ' .. bufnr)
      if vim.bo[bufnr].modified then
        vim.notify('Buffer is modified, saving before setting relative path: ' .. bufname)
        vim.api.nvim_set_current_buf(bufnr)
        vim.cmd('w')
        vim.api.nvim_buf_set_name(bufnr, relative_path)
        vim.cmd('e')
      else
        vim.api.nvim_set_current_buf(bufnr)
        vim.api.nvim_buf_set_name(bufnr, relative_path)
        vim.cmd('e')
      end
    end)
  end
end

vim.api.nvim_create_autocmd({
  'BufWinEnter',
  'BufWritePost',
}, {
  pattern = '*',
  callback = function(event)
    open_file_buf_relative_path(event.buf)
  end,
})
