local g = vim.g

g.db_ui_use_nerd_fonts = 1
g.db_ui_auto_execute_table_helpers = 1
g.db_ui_winwidth = 80

vim.keymap.set("n", "<leader>td", ":DBUI<CR>", {desc = "dadbod ui"}) 
