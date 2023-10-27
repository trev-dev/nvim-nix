vim.api.nvim_set_hl(1, "TreesitterContextSeparator", { link = "FloatBorder" })

require("treesitter-context").setup({
  separator = "┄"
})
