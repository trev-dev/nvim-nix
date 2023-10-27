local dapui = require("dapui")
local dap = require("dap")

dapui.setup({
  floating = {
    border = "single",
    mappings = {close = {"q", "<Esc>"}},
    max_height = nil,
    max_width = nil
  },
  icons = {
    collapsed = "▸",
    current_frame = "*",
    expanded = "▾"
  },
  layouts = {
    {
      elements = {"stacks", "breakpoints", "scopes"},
      position = "right",
      size = 40
    },
    {
      elements = {"console", "repl"},
      position = "bottom",
      size = 0.25
    }
  }
})

vim.fn.sign_define("DapBreakpoint", {
  linehl = "",
  numhl = "",
  text = "",
  texthl = "DiagnosticSignError"
})

local map = vim.keymap.set
map("n", "<F3>", dap.disconnect)
map("n", "<F5>", dap.continue)
map("n", "<F6>", dap.pause)
map("n", "<F9>", dap.toggle_breakpoint, {desc = "toggle breakpoint"})
map("n", "<leader><F9>", dap.set_breakpoint, {desc = "set breakpoint"})
map("n", "<F10>", dap.step_over)
map("n", "<F11>", dap.step_into)
map("n", "<F12>", dap.step_out)
map("n", "<leader>dr", dap.repl.open, {desc = "open repl"})
map("n", "<leader>dl", dap.run_last, {desc = "run last"})
map("n", "<leader>dc", dap.clear_breakpoints, {desc = "run last"})
map({"v", "n"}, "<leader>dh", dapui.eval, {desc = "eval cursor/selection"})

local function open_ui()
  return dapui.open()
end
local function close_ui()
  return dapui.close()
end

local l = dap.listeners
l.after.event_initialized["dapui_config"] = open_ui
l.before.event_terminated["dapui_config"] = close_ui
l.before.event_exited["dapui_config"] = close_ui

local wk = require("which-key")
wk.register({d = {name = "[d]ebug"}, prefix = "<leader>"})

