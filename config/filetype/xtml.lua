local au = vim.api.nvim_create_autocmd
local grp = vim.api.nvim_create_augroup("HTMLFiletypes", {clear = true})
local function set_ruler()
  vim.opt_local.colorcolumn = "120"
  return nil
end

-- These settings are for any filetype that represents HTML in one form or
-- or another.  This includes xml, vue, react, svelte, whatever.  This is
-- mostly for setting the stupid ruler.

au({"FileType"}, {
  group = grp,
  pattern = "vue",
  callback = set_ruler
})

au({"FileType"}, {
  group = grp,
  pattern = "html",
  callback = set_ruler
})

au({"FileType"}, {
  group = grp,
  pattern = "jsx",
  callback = set_ruler
})

au({"FileType"}, {
  group = grp,
  pattern = "svelte",
  callback = set_ruler
})

au({"FileType"}, {
  group = grp,
  pattern = "xml",
  callback = set_ruler
})
