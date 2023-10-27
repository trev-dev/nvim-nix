local o = require("oil")

o.setup({
  default_file_explorer = false
})

vim.keymap.set("n", "<leader>o", function() o.open() end)
