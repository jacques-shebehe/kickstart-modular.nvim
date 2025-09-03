local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = { '*' },
  command = 'checktime',
})

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = { '*' },
  callback = function(_)
    vim.cmd.setlocal 'nonumber'
    vim.wo.signcolumn = 'no'
    set_terminal_keymaps()
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- -- format on save using efm langserver and configured formatters
-- local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = lsp_fmt_group,
-- 	callback = function() -- install efm formater.
-- 		local efm = vim.lsp.get_clients({ name = "efm" })
-- 		if vim.tbl_isempty(efm) then
-- 			return
-- 		end
-- 		vim.lsp.buf.format({ name = "efm", async = true })
-- 	end,
-- })
-- -- fyle type to .tmpl files
-- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
--   pattern = {'*.tmpl'},
--   callback = function(args)
--     local fname = vim.fn.fnamemodify(args.file, ':t')
--     local match = fname:match('.*%.([a-zA-Z0-9_-]+)%.tmpl$')
--     if match then
--       vim.bo.filetype = match
--     end
--   end,
-- })

-- fyle type to .tmpl files
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'*.tmpl'},
  callback = function(args)
    local fname = vim.fn.fnamemodify(args.file, ':t')
    local match = fname:match('.*%.([a-zA-Z0-9_-]+)%.tmpl$')
    if match then
      vim.bo.filetype = match
    end
  end,
})
-- template for .zshrc and .bashrc files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "shell-common.tmpl",
  callback = function(args)
    vim.bo[args.buf].filetype = "sh"
  end,
})
