-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set('n', '<leader>n', ':noh<CR>')
-- vim.keymap.set('n', '<A-o>', ':LspClangdSwitchSourceHeader<CR>')
vim.keymap.set('n', '<leader>o', ':ClangdSwitchSourceHeader<CR>')
vim.keymap.set('n', '<A-o>', ':ClangdSwitchSourceHeader<CR>')
vim.keymap.set({ 'n' }, '<leader>q', ':x!<CR>')
vim.keymap.set('n', '<A-]>', ':vertical resize +5<CR>')
vim.keymap.set('n', '<A-[>', ':vertical resize -5<CR>')
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')
-- vim.keymap.set('n', '<A-p>', ':GetCurrentFunctions<CR>')
-- vim.keymap.set('n', '<A-p>', ':SymbolsOutline<CR>')
-- vim.keymap.set("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })
-- vim.keymap.set("n", "<leader>r", ":IncRename ")
vim.keymap.set("n", "<C-s>", ":w!<CR>")
vim.keymap.set("i", "<C-s>", "<C-\\><C-o>:w<CR>")
-- vim.keymap.set({"n", "v"}, "<A-Up>", ":m-2<CR>")
-- vim.keymap.set({"n", "v"}, "<A-Down>", ":m+<CR>")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- switch back and forth between last used buffers
vim.keymap.set({ "n", "i" }, "<C-Tab>", "<C-^>")
-- vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>")
-- Map a shortcut to open the picker.
-- vim.api.nvim_set_keymap("n", "<Leader><Leader>",
--   [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
--   {noremap = true, silent = true})

-- vim.keymap.set("n", "<leader>ll", function()
--     require('telescope-tabs').list_tabs()
-- end)

vim.keymap.set({ "n", "v" }, ">", ">gv", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<", "<gv", { noremap = true, silent = true })


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Perforce
-- vim.keymap.set("n", "<leader>pa", function() require("p4").P4edit() end)
