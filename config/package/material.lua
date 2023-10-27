local m = require("material")
local colors = require("material.colors")

m.setup({
  styles = { comments = { italic = true }},
  plugins = {
    "dap",
    "gitsigns",
    "hop",
    "indent-blankline",
    "neorg",
    "nvim-cmp",
    "nvim-tree",
    "telescope",
    "which-key"
  },
  disable = { background = true },
  lualine_style = "stealth",
  high_visibility = { darker = "true" },
  custom_highlights = {
    ["@text.reference"] = { fg = colors.main.darkred }
  },
  custom_colors = function(colors)
    colors.editor.accent = colors.main.paleblue
  end
})

vim.g.material_style = "darker"
vim.cmd.colorscheme("material")
