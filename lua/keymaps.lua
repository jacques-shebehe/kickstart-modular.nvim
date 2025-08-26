-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

--  change <ESC> with j-j
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'From I mode to N mode' })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- File Explorer
-- nvim-tree
-- vim.keymap.set('n', '<leader>m', '<Cmd>NvimTreeFocus<CR>', { desc = 'Focus on File Explorer' })
-- vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })

-- lua/keymaps.lua

-- Toggle Oil file explorer with <leader>e
vim.keymap.set('n', '<leader>e', function()
  local ok, oil = pcall(require, 'oil')
  if not ok then
    vim.notify('oil.nvim is not loaded', vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype

  -- If we're not in oil, remember this buffer and open oil
  if ft ~= 'oil' then
    vim.g.last_file_buf = vim.api.nvim_get_current_buf()
    oil.open()
  else
    -- If we are in oil, return to last file buffer
    if vim.g.last_file_buf and vim.api.nvim_buf_is_valid(vim.g.last_file_buf) then
      vim.api.nvim_set_current_buf(vim.g.last_file_buf)
    else
      vim.cmd 'b#' -- fallback: go to alternate buffer
    end
  end
end, { desc = 'Toggle Oil file explorer' })
-- vim: ts=2 sts=2 sw=2 et
