local zk = require("zk")

zk.setup({
  picker = "telescope"
})

local map = vim.keymap.set
map("n", "<leader>zf", ":ZkNotes<CR>", { desc = "find note" })
map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", { desc = "find note" })
map("n", "<leader>zn", ":ZkNew { title = vim.fn.input('Title: ') }<CR>", {
  desc = "new note"
})
map("n", "<leader>zt", ":ZkTags<CR>", { desc = "note tags" })

local wk = require("which-key")
wk.register({
  prefix = "<leader>",
  z = { name = "ZK notes" }
})
