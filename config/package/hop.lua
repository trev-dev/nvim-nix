local h = require("hop")

h.setup({keys = "etovxqpdygfblzhckisuran", case_insensitive = false})

vim.keymap.set("n", "<leader>s", ":HopChar1<CR>", {silent = true})
