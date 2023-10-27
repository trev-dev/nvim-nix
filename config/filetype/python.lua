vim.api.nvim_create_autocmd({"FileType"}, {
  group = vim.api.nvim_create_augroup("PythonIndent", {clear = true}),
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end
})
