local ibl = require("ibl")

ibl.setup({
  scope = { enabled = false },
  exclude = {
    filetypes = {
      "lspinfo",
      "packer",
      "checkhealth",
      "help",
      "txt",
      "markdown",
      "norg",
      "org",
      "norg"
    }
  }
})
