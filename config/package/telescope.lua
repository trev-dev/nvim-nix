local telescope = require('telescope')
local themes = require('telescope.themes')

telescope.setup({
  defaults = { path_display = { truncate = 3 }},
  extensions = {
    ['ui-select'] = {
      themes.get_dropdown {}
    }
  }
})

telescope.load_extension('ui-select')

local map = vim.keymap.set
local builtin = require('telescope.builtin')
local pickLastBuffer = function()
  builtin.buffers({sort_lastused = true})
end

map('n', '<leader>ff', builtin.find_files, {desc = 'files'})
map('n', '<leader>fr', builtin.live_grep, {desc = 'grep'})
map('n', '<leader>fg', builtin.git_files, {desc = 'git files'})
map('n', '<leader>fb', pickLastBuffer, {desc = 'buffers'})
map('n', '<leader>fh', builtin.help_tags, {desc = 'help tags'})
