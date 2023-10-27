local mdf = require("mkdnflow")

mdf.setup({
  filetypes = {
    markdown = true,
    md = true,
    org = true
  },
  mappings = {
    MkdnNewListItem = {"i", "<CR>"},
    MkdnYankAnchorLink = {"n", "yl"},
    MkdnYankFileAnchorLink = {"n", "yfl"}
  }
})
