-- Only needed on Windows; Macs usually have SQLite in the default search path
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  -- \\ in Lua strings → \ on disk
  vim.g.sqlite_clib_path = "C:\\ProgramData\\chocolatey\\lib\\sqlite\\tools\\sqlite3.dll"
end
-- Settings for vscode-neovim
if vim.g.vscode then
--   -- Set <space> as the leader key
--   -- See `:help mapleader`
--   --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '

 vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- Make line numbers default
  vim.opt.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  vim.opt.relativenumber = true
  --

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.opt.mouse = 'a'
--
--   -- Don't show the mode, since it's already in the status line
--   vim.opt.showmode = false
--
--   -- Sync clipboard between OS and Neovim.
--   --  Schedule the setting after `UiEnter` because it can increase startup-time.
--   --  Remove this option if you want your OS clipboard to remain independent.
--   --  See `:help 'clipboard'`
--   vim.schedule(function()
--     vim.opt.clipboard = 'unnamedplus'
--   end)
--
--   -- Enable break indent
--   vim.opt.breakindent = true
--
--   -- Save undo history
--   vim.opt.undofile = true
--
--   -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
--   vim.opt.ignorecase = true
--   vim.opt.smartcase = true
--
--   -- Keep signcolumn on by default
--   vim.opt.signcolumn = 'yes'
--
--   -- Preview substitutions live, as you type!
--   vim.opt.inccommand = 'split'
--   -- Show which line your cursor is on
--   vim.opt.cursorline = true
--
--   -- Minimal number of screen lines to keep above and below the cursor.
--   vim.opt.scrolloff = 10
--
--   -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
--   -- instead raise a dialog asking if you wish to save the current file(s)
--   -- See `:help 'confirm'`
--   vim.opt.confirm = true

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

require 'config.lazy-bootstrap'
-- -- [[ Install `lazy.nvim` plugin manager ]]
-- --    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
--   if vim.v.shell_error ~= 0 then
--     error('Error cloning lazy.nvim:\n' .. out)
--   end
-- end
--
-- ---@type vim.Option
-- local rtp = vim.opt.rtp
-- rtp:prepend(lazypath)
--
--   -- Now that lazy.nvim path has been prepended by bootstrap.lua,
--   -- require lazy safely and call setup
--
--   -- Now require lazy safely
--   local ok, lazy = pcall(require, 'lazy')
--   if not ok then
--     vim.notify('Failed to load lazy.nvim', vim.log.levels.ERROR)
--     return
--   end
--   -- Set up plugins via lazy.nvim
--   lazy.setup {
--     {
--       'echasnovski/mini.nvim',
--       version = false,
--       config = function()
--         -- Better Around/Inside textobjects
--         --
--         -- Examples:
--         --  - va)  - [V]isually select [A]round [)]paren
--         --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--         --  - ci'  - [C]hange [I]nside [']quote
--         require('mini.ai').setup { n_lines = 500 }
--
--         -- Add/delete/replace surroundings (brackets, quotes, etc.)
--         -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--         -- - sd'   - [S]urround [D]elete [']quotes
--         -- - sr)'  - [S]urround [R]eplace [)] [']
--         require('mini.surround').setup()
--         -- add pairs of "'{[ automatically
--         require('mini.pairs').setup()
--         -- comment (language-specific) lines in normal or visual mode
--         require('mini.comment').setup()
--         -- gcc - comment a line (visual block) or uncomment commented line (visual block)
--       end,
--     },
--   }
  -- load ONLY the mini-suite (the table returned by lua/plugins/mini.lua)
  -- local mini_spec = require('plugins.mini') -- if only this plugin
  local mini_spec = {
  require('plugins.mini'),                -- existing Mini suite
  require('plugins.vim-visual-multi'),    -- new plugin added via require
  -- more plugins? just keep adding require('plugins.xxx')
}

  require('lazy').setup(mini_spec, {
    root     = vim.fn.stdpath('data') .. '/lazy-vscode', -- separate install dir
    defaults = { version = false },                      -- same defaults as desktop
  })

  return
--   -- below is common quarto nvim-config
else

-- NOTE: Throughout this config, some plugins are
-- disabled by default. This is because I don't use
-- them on a daily basis, but I still want to keep
-- them around as examples.
-- You can enable them by changing `enabled = false`
-- to `enabled = true` in the respective plugin spec.
-- Some of these also have the
-- PERF: (performance) comment, which
-- indicates that I found them to slow down the config.
-- (may be outdated with newer versions of the plugins,
-- check for yourself if you're interested in using them)

-- vim.treesitter.language.add('pandoc_markdown', { path = "/usr/local/lib/libtree-sitter-pandoc-markdown.so" })
-- vim.treesitter.language.add('pandoc_markdown_inline', { path = "/usr/local/lib/libtree-sitter-pandoc-markdown-inline.so" })
-- vim.treesitter.language.register('pandoc_markdown', { 'quarto', 'rmarkdown' })

require 'config.global'
require 'config.lazy'
require 'config.autocommands'
require 'config.redir'

vim.cmd.colorscheme 'oscura'
vim.api.nvim_set_hl(0, 'TermCursor', { fg = '#A6E3A1', bg = '#A6E3A1' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'dimgray', bg = '' })

end
