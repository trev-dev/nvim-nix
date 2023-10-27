local signs = {
  Error = "»",
  Warn = "»",
  Hint = "›",
  Info = "›"
}
for k, v in pairs(signs) do
  local hl = "DiagnosticSign" .. k
  vim.fn.sign_define(hl, {text = v, texthl = hl, numhl = hl})
end

vim.diagnostic.config({
  signs = {active = signs},
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {border = "single", source = "always", header = "", prefix = ""}
}) 

local function set_lsp_mappings(event)
  local map = vim.keymap.set
  local buf = vim.lsp.buf
  local opts = {buffer = event.buf}
  local function with_desc(desc)
    return {buffer = event.buf, desc = desc}
  end

  vim.bo[event.buf]["omnifunc"] = "v:lua.vim.lsp.omnifunc"

  map("n", "H", vim.diagnostic.open_float, opts)
  map("n", "[d", vim.diagnostic.goto_prev, {desc = "previous diagnostc"})
  map("n", "]d", vim.diagnostic.goto_next, {desc = "next diagnostc"})
  map("n", "gD", buf.declaration, {desc = "goto [D]iagnostic"})
  map("n", "gd", buf.definition, {desc = "goto [d]efinition"})
  map("n", "K", buf.hover, opts)
  map("n", "gi", buf.implementation, {desc = "goto [i]mplementation"})
  map("n", "<C-k>", buf.signature_help, opts)

  local function list_folders()
    return vim.inspect(buf.list_workspace_folders())
  end
  local function format_buffer()
    return buf.format({async = true})
  end

  local wk = require("which-key")
  wk.register({w = {name = "lsp [w]orkspace"}, prefix = "<localleader>"}) 
  map("n", "<localleader>wa", buf.add_workspace_folder, with_desc("[a]dd folder"))
  map("n", "<localleader>wr", buf.remove_workspace_folder, with_desc("[r]emove folder"))
  map("n", "<localleader>wl", list_folders, with_desc("[l]ist folders"))
  map("n", "<localleader>D", buf.type_definition, with_desc("goto type [D]efinition"))
  map("n", "<localleader>r", buf.rename, with_desc("[r]ename symbol"))
  map({"n", "v"}, "<localleader>c", buf.code_action, with_desc("[c]ode action"))
  map("n", "gr", buf.references, with_desc("goto [r]eferences"))
  map("n", "<localleader>F", format_buffer, with_desc("[F]ormat buffer"))
  map("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
  map("n", "<leader>fws", ":Telescope lsp_workspace_symbols<CR>", opts)
end

local servers = {
  {"bashls", {}},
  {"cssls", {}},
  {"html", {}},
  {"gdscript", {}},
  {"hls", {}},
  {"lua_ls", {}},
  {"rnix", {}},
  {"jsonls", {}},
  {"nimls", {}},
  {"tsserver", {}},
  {"eslint", {}},
  {"volar", {
    filetypes = {"vue"}
  }},
  {"yamlls", {}}
}

local lspcfg = require("lspconfig")
for _, conf in pairs(servers) do
  local lang = conf[1]
  local options = conf[2]
  lspcfg[lang].setup(options)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = set_lsp_mappings
})

local windows = require("lspconfig.ui.windows")
windows.default_options.border = "single"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = "single"}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = "rounded"}
)

local lspsig = require("lsp_signature")
lspsig.setup({
  bind = true,
  handler_opts = {border = "single"},
  doc_lines = 0,
  hint_enable = false
}) 
