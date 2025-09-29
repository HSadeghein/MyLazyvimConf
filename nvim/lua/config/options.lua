-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Add this at the top of your file
vim.g.mapleader = " " -- Sets leader key to space
vim.g.maplocalleader = " "
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


vim.wo.number = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- vim.opt.shellslash = true -- Use forward slashes on Windows

---WORKAROUND
-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })
-- vim.opt.foldenable = false
---ENDWORKAROUND

-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = '#6A9955', bg = 'NONE' })

local set = vim.opt -- set options


-- set.mouse = a
set.wrap = false
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.smartindent = true

set.listchars = { tab = "> ", space = "•", trail = "." }
set.list = true
set.clipboard = "unnamedplus"

set.cursorline = true
set.signcolumn = "yes:1"
set.updatetime = 10

set.swapfile = false
set.backup = false
set.undofile = true

set.hlsearch = true
set.incsearch = true

set.termguicolors = true

vim.o.winborder = 'rounded'

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.shellslash = true


-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
-- local language_servers = vim.lsp.get_clients({ 'clangd' }) -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--     require('lspconfig')[ls].setup({
--         capabilities = capabilities
--         -- you can add other fields for setting up lsp server in this table
--     })
-- end

-- set.foldlevel = 99
-- set.foldlevelstart = 99
-- set.foldnestmax = 4
-- set.foldcolumn = "0"
-- set.foldtext = ""
-- set.foldmethod = "expr"
-- set.foldexpr = "nvim_treesitter#foldexpr()"

set.scrolloff = 8


-- vim.filetype.add(
--     {
--         extensions =
--         {
--             hlsl = 'slang', -- make .hlsl files to have hlsl filetype so treesitter gives it proper highlight
--         }
--     })
vim.g.neovide_cursor_animation_length = 0.0
vim.g.neovide_cursor_trail_size = 0.0
vim.g.neovide_fullscreen = true
vim.o.guifont = "JetBrainsMonoNL NFM:h12"
vim.g.neovide_scroll_animation_length = 0.1
