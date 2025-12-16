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

vim.o.pumheight = 6
--vim.o.pumborder = 'single'  -- Available from nvim v0.12

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

----------------------------
--- Mini.Files slideshow ---
----------------------------

-- Source: https://www.reddit.com/r/neovim/comments/1pm2m6i/cool_minifiles_sidescrolling_layout/
-- Window width based on the offset from the center, i.e. center window
-- is 60, then next over is 20, then the rest are 10.
-- Can use more resolution if you want like { 60, 20, 20, 10, 5 }
local widths = { 60, 20, 10 }

local ensure_center_layout = function(ev)
  local state = MiniFiles.get_explorer_state()
  if state == nil then return end

  -- Compute "depth offset" - how many windows are between this and focused
  local path_this = vim.api.nvim_buf_get_name(ev.data.buf_id):match('^minifiles://%d+/(.*)$')
  local depth_this
  for i, path in ipairs(state.branch) do
    if path == path_this then depth_this = i end
  end
  if depth_this == nil then return end
  local depth_offset = depth_this - state.depth_focus

  -- Adjust config of this event's window
  local i = math.abs(depth_offset) + 1
  local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
  win_config.width = i <= #widths and widths[i] or widths[#widths]

  win_config.col = math.ceil(0.5 * (vim.o.columns - widths[1]))
  for j = 1, math.abs(depth_offset) do
    local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
    -- widths[j+1] for the negative case because we don't want to add the center window's width
    local prev_win_width = (sign == -1 and widths[j + 1]) or widths[j] or widths[#widths]
    -- Add an extra +2 each step to account for the border width
    win_config.col = win_config.col + sign * (prev_win_width + 2)
  end

  win_config.height = depth_offset == 0 and 25 or 20
  win_config.row = math.ceil(0.5 * (vim.o.lines - win_config.height))
  -- win_config.border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
  vim.api.nvim_win_set_config(ev.data.win_id, win_config)
end

vim.api.nvim_create_autocmd("User", { pattern = "MiniFilesWindowUpdate", callback = ensure_center_layout })

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
