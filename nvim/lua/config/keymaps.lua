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



-- CTRL TAB
-- switch back and forth between last used buffers
-- vim.keymap.set({ "n", "i" }, "<C-Tab>", "<C-^>")

-- VS Code-style buffer navigation with telescope (added to mystuff.lua)
-- Simple quick buffer cycling (uncomment if you prefer this over telescope)
-- vim.keymap.set("n", "<C-Tab>", "<C-^>", { desc = "Switch to last buffer" })

-- Alternative: Cycle through buffers in MRU order
local function cycle_buffers(direction)
    local buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted') then
            table.insert(buffers, buf)
        end
    end

    if #buffers <= 1 then return end

    local current = vim.api.nvim_get_current_buf()
    local current_idx = 1

    for i, buf in ipairs(buffers) do
        if buf == current then
            current_idx = i
            break
        end
    end

    local next_idx
    if direction == 'next' then
        next_idx = current_idx == #buffers and 1 or current_idx + 1
    else
        next_idx = current_idx == 1 and #buffers or current_idx - 1
    end

    vim.api.nvim_set_current_buf(buffers[next_idx])
end

-- Uncomment these if you prefer simple cycling over telescope picker
-- vim.keymap.set("n", "<C-Tab>", function() cycle_buffers('next') end, { desc = "Next buffer" })
-- vim.keymap.set("n", "<C-S-Tab>", function() cycle_buffers('prev') end, { desc = "Previous buffer" })
-- CTRL TAB




vim.keymap.set({ "n", "v" }, ">", ">gv", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<", "<gv", { noremap = true, silent = true })


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Perforce
-- vim.keymap.set("n", "<leader>pa", function() require("p4").P4edit() end)
