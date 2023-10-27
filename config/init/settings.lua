vim.o.mouse = "a"
vim.o.termguicolors = true
vim.o.listchars = "tab:>·,trail:~"
vim.o.list = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.showbreak = "󱞩"
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.lbr = true
vim.o.redrawtime = 10000
vim.o.clipboard = "unnamedplus"
vim.o.guifont = "FiraCode Nerd Font 12"

vim.wo.breakindent = true
vim.wo.breakindentopt = "sbr"
vim.wo.colorcolumn = "80"
vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"
vim.wo.linebreak = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = true

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.html_indent_script1 = "zero"
vim.g.html_indent_style1 = "zero"

if os.getenv "BROWSER" == "wslview" then
  vim.g.netrw_browsex_viewer = "wslview"
end

-- Toggle relative line numbers to make showing the line numbers more team lead
-- friendly
vim.g.MarcoMode = false

local setMarcoMode = function(enable)
  vim.wo.number = enable
  vim.wo.relativenumber = not enable
end

local toggleMarcoMode = function()
  vim.g.MarcoMode = not vim.g.MarcoMode
  setMarcoMode(vim.g.MarcoMode)
end

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function() setMarcoMode(vim.g.MarcoMode) end
})

vim.api.nvim_create_user_command ("MarcoMode", toggleMarcoMode, {
  desc = "Make line numbers Marco friendly"
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { group = "Visual", timeout = 350 }
  end
})

vim.keymap.set("n", "<leader>l", ":noh<CR>", {
  desc = "C[l]ear search highlights"
})
