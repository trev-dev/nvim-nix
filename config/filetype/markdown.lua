local bo = vim.bo
local lo = vim.opt_local
local wo = vim.wo

vim.api.nvim_create_autocmd({"FileType"}, {
  group = vim.api.nvim_create_augroup("MarkdownCustom", {clear = true}),
  pattern = "markdown",
  callback = function()
    wo.wrap = false
    bo.shiftwidth = 2
    bo.softtabstop = 2
    bo.tabstop = 2
    bo.textwidth = 80
    lo.conceallevel = 2
    lo.colorcolumn = "80"
    lo.foldlevel = 99
  end
})
