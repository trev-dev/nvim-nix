local ap = require("nvim-autopairs")
local quotes = {"'", "`"}
local disable_quote_filetypes = {
  "scheme",
  "lisp",
  "fennel",
  "clojure",
  "guile"
}

ap.setup({ enable_check_bracket_line = false })

for _, q in ipairs(quotes) do
  ap.get_rules(q)[1].not_filetypes = disable_quote_filetypes
end
