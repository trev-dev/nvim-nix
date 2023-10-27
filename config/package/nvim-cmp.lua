local cmp = require("cmp")
local snip = require("luasnip")
local autopairs = require("nvim-autopairs.completion.cmp")
local dap = require("cmp_dap")

local function snippet_expand(args)
  return snip.lsp_expand(args.body)
end

local function cmp_next(fallback)
  if cmp.visible() then
    return cmp.select_next_item()
  else
    return fallback()
  end
end

local function cmp_prev(fallback)
  if cmp.visible() then
    return cmp.select_prev_item()
  else
    return fallback()
  end
end

local get_opt = vim.api.nvim_buf_get_option
local function enable()
  return get_opt(0, "buftype") ~= "prompt" or dap.is_dap_buffer()
end

cmp.setup({
  snippet = snippet_expand,
  mapping = {
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(( - 4)), {"i", "c"}),
    ["<C-e>"] = cmp.mapping({c = cmp.mapping.close(), i = cmp.mapping.abort()}),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
    ["<C-n>"] = cmp.mapping(cmp_next, {"i", "s", "c"}),
    ["<C-p>"] = cmp.mapping(cmp_prev, {"i", "s", "c"}),
    ["<C-y>"] = cmp.config.disable,
    ["<CR>"] = cmp.mapping.confirm({select = true})
  },
  sources = cmp.config.sources({
    {name = "nvim_lsp"},
    {name = "vsnip"},
    {name = "path"}
  }, {{name = "buffer"}}),
  enabled = enable
})

cmp.setup.cmdline({"/", "?"}, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {{name = "buffer"}}
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
})

cmp.setup.filetype(
  {"dap-repl", "dapui_watches", "dapui_hover"},
  {sources = {{name = "dap"}}}
)

cmp.event:on("confirm_done", autopairs.on_confirm_done())
