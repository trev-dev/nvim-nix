local onAttachGitsigns = function(bufnr)
  local gs = package.loaded.gitsigns
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true, desc = "Next [h]unk" })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true, desc = "Previous [h]unk" })

  -- Actions
  map('n', '<leader>hs', gs.stage_hunk, { desc = "[s]tage hunk" })
  map('n', '<leader>hr', gs.reset_hunk, { desc = "[r]eset hunk" })
  map('v', '<leader>hs', function()
    gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
  end, { desc = "[s]tage visual hunk"})
  map('v', '<leader>hr', function()
    gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
  end, { desc = "[r]eset visual hunk" })
  map('n', '<leader>hS', gs.stage_buffer, { desc = "[S]tage buffer "})
  map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[u]ndo hunk" })
  map('n', '<leader>hR', gs.reset_buffer, { desc = "[R]eset buffer" })
  map('n', '<leader>hp', gs.preview_hunk, { desc = "[p]review hunk" })
  map('n', '<leader>hb', function()
    gs.blame_line({ full = true })
  end, { desc = "[b]lame line" })
  map('n', '<leader>hB', gs.toggle_current_line_blame, {
    desc = "toggle [B]lame line"
  })
  map('n', '<leader>ht', gs.diffthis, { desc = "diff [t]his" })
  map('n', '<leader>hT', function() gs.diffthis('~') end, {
    desc = "diff [T]his ~"
  })
  map('n', '<leader>td', gs.toggle_deleted, { desc = "toggle [d]eleted" })

  -- Text object
  map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

  local wk = require("which-key")
  wk.register({
    h = { name = "Gitsigns [h]unk", prefix = "<leader>" }
  })
end

local gs = require("gitsigns")
gs.setup({ on_attach = onAttachGitsigns })
