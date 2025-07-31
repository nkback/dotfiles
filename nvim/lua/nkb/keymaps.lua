vim.g.mapleader = " "
vim.keymap.set("n", "<leader>v", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>D", [["+dd]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>j", "mzJ`z")
vim.keymap.set("n", "gp", "`[v`]", { noremap = true })

vim.keymap.set("n", "<leader>q", ":lua vim.diagnostic.setqflist()<CR>")

vim.keymap.set("n", "<leader>lf", function()
  local file = vim.fn.expand("%")
  local cmd = string.format("./vendor/bin/phpstan analyze --memory-limit=1G %s", file)
  vim.cmd("split | terminal " .. cmd)
end, { desc = "Run Larastan on current file" })

