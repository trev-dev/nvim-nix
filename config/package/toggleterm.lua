local tt = require("toggleterm")

tt.setup({
  close_on_exit = true,
  open_mapping = "<A-t>",
  direction = "float",
  float_opts = {
    border = "curved",
    highlights = {background = "Normal", border = "Normal"},
    winblend = 0
  },
  hide_numbers = true,
  insert_mappings = true,
  persist_size = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  shell = vim.o.shell,
  start_in_insert = true
})

local Terminal = (require("toggleterm.terminal")).Terminal
local map = vim.keymap.set
local lazygit = Terminal:new({cmd = "lazygit", hidden = true})
local taskwarrior_tui = Terminal:new({cmd = "taskwarrior-tui", hidden = true})

local function toggle_lazygit()
  lazygit.dir = vim.fn.getcwd()
  return lazygit:toggle()
end

local function toggle_tui()
  return taskwarrior_tui:toggle()
end

map("n", "<leader>tg", toggle_lazygit, {desc = "lazygit"})
map("n", "<leader>tt", toggle_tui, {desc = "taskwarrior-tui"}) 
