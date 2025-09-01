-- global options

local animals = require('misc.style').animals

DefaultConcealLevel = 0
FullConcealLevel = 3

-- proper colors
vim.opt.termguicolors = true

-- show insert mode in terminal buffers
vim.api.nvim_set_hl(0, 'TermCursor', { fg = '#A6E3A1', bg = '#A6E3A1' })

-- disable fill chars (the ~ after the buffer)
vim.o.fillchars = 'eob: '

-- more opinionated
vim.opt.number = true -- show linenumbers
vim.opt.relativenumber = true
vim.opt.mouse = 'a' -- enable mouse
vim.opt.mousefocus = true
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard

vim.opt.timeoutlen = 2000-- until which-key pops up
vim.opt.updatetime = 250 -- for autocommands and hovers

-- don't ask about existing swap files
vim.opt.shortmess:append 'A'

-- mode is already in statusline
vim.opt.showmode = false

-- use less indentation
local tabsize = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize

-- space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--  change <ESC> with j-j
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'From I mode to N mode' })


-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- consistent number column
vim.opt.signcolumn = 'yes:1'

-- how to show autocomplete menu
vim.opt.completeopt = 'menuone,noinsert'

-- global statusline
vim.opt.laststatus = 3

vim.cmd [[
let g:currentmode={
       \ 'n'  : '%#String# NORMAL ',
       \ 'v'  : '%#Search# VISUAL ',
       \ 's'  : '%#ModeMsg# VISUAL ',
       \ "\<C-V>" : '%#Title# V·Block ',
       \ 'V'  : '%#IncSearch# V·Line ',
       \ 'Rv' : '%#String# V·Replace ',
       \ 'i'  : '%#ModeMsg# INSERT ',
       \ 'R'  : '%#Substitute# R ',
       \ 'c'  : '%#CurSearch# Command ',
       \ 't'  : '%#ModeMsg# TERM ',
       \}
]]

math.randomseed(os.time())
local i = math.random(#animals)
vim.opt.statusline = '%{%g:currentmode[mode()]%} %{%reg_recording()%} %* %t | %y | %* %= c:%c l:%l/%L %p%% %#NonText# '
  .. animals[i]
  .. ' %*'

-- hide cmdline when not used
vim.opt.cmdheight = 1

-- split right and below by default
vim.opt.splitbelow = true
vim.opt.splitright = true

--tabline
vim.opt.showtabline = 1

--windowline
vim.opt.winbar = '%f'

-- don't continue comments automagically
vim.opt.formatoptions:remove 'c'
vim.opt.formatoptions:remove 'r'
vim.opt.formatoptions:remove 'o'

-- set formatoptions again in an autocmd to override
-- ft specific plugins
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function(_)
    vim.opt.formatoptions:remove 'c'
    vim.opt.formatoptions:remove 'r'
    vim.opt.formatoptions:remove 'o'
  end,
})

-- scroll before end of window
vim.opt.scrolloff = 5

-- (don't == 0) replace certain elements with prettier ones
vim.opt.conceallevel = DefaultConcealLevel

-- diagnostics
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

-- add new filetypes
vim.filetype.add {
  extension = {
    ojs = 'javascript',
    pyodide = 'python',
    webr = 'r',
  },
}

-- additional builtin vim packages
-- filter quickfix list with Cfilter
vim.cmd.packadd 'cfilter'


-- -- ================================================================================================
-- -- TITLE : NeoVim options
-- -- ABOUT : basic settings native to neovim
-- -- ================================================================================================
--
-- -- Basic Settings
-- vim.opt.number = true -- Line numbers
-- vim.opt.relativenumber = true -- Relative line numbers
-- vim.opt.cursorline = true -- Highlight current line
-- vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
-- vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
-- vim.opt.wrap = false -- Don't wrap lines
-- vim.opt.cmdheight = 1 -- Command line height
-- vim.opt.spelllang = { "en", "de" } -- Set language for spellchecking
--
-- -- Tabbing / Indentation
-- vim.opt.tabstop = 2 -- Tab width
-- vim.opt.shiftwidth = 2 -- Indent width
-- vim.opt.softtabstop = 2 -- Soft tab stop
-- vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.smartindent = true -- Smart auto-indenting
-- vim.opt.autoindent = true -- Copy indent from current line
-- vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep if available
-- vim.opt.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content
--
-- -- Search Settings
-- vim.opt.ignorecase = true -- Case-insensitive search
-- vim.opt.smartcase = true -- Case-sensitive if uppercase in search
-- vim.opt.hlsearch = false -- Don't highlight search results
-- vim.opt.incsearch = true -- Show matches as you type
--
-- -- Visual Settings
-- vim.opt.termguicolors = true -- Enable 24-bit colors
-- vim.opt.signcolumn = "yes" -- Always show sign column
-- vim.opt.colorcolumn = "100" -- Show column at 100 characters
-- vim.opt.showmatch = true -- Highlight matching brackets
-- vim.opt.matchtime = 2 -- How long to show matching bracket
-- vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
-- vim.opt.showmode = false -- Don't show mode in command line
-- vim.opt.pumheight = 10 -- Popup menu height
-- vim.opt.pumblend = 10 -- Popup menu transparency
-- vim.opt.winblend = 0 -- Floating window transparency
-- vim.opt.conceallevel = 0 -- Don't hide markup
-- vim.opt.concealcursor = "" -- Show markup even on cursor line
-- vim.opt.lazyredraw = false -- redraw while executing macros (butter UX)
-- vim.opt.redrawtime = 10000 -- Timeout for syntax highlighting redraw
-- vim.opt.maxmempattern = 20000 -- Max memory for pattern matching
-- vim.opt.synmaxcol = 300 -- Syntax highlighting column limit
--
-- -- File Handling
-- vim.opt.backup = false -- Don't create backup files
-- vim.opt.writebackup = false -- Don't backup before overwriting
-- vim.opt.swapfile = false -- Don't create swap files
-- vim.opt.undofile = true -- Persistent undo
-- vim.opt.updatetime = 300 -- Time in ms to trigger CursorHold
-- vim.opt.timeoutlen = 500 -- Time in ms to wait for mapped sequence
-- vim.opt.ttimeoutlen = 0 -- No wait for key code sequences
-- vim.opt.autoread = true -- Auto-reload file if changed outside
-- vim.opt.autowrite = false -- Don't auto-save on some events
-- vim.opt.diffopt:append("vertical") -- Vertical diff splits
-- vim.opt.diffopt:append("algorithm:patience") -- Better diff algorithm
-- vim.opt.diffopt:append("linematch:60") -- Better diff highlighting (smart line matching)
--
-- -- Set undo directory and ensure it exists
-- local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
-- vim.opt.undodir = vim.fn.expand(undodir) -- Expand to full path
-- local undodir_path = vim.fn.expand(undodir)
-- if vim.fn.isdirectory(undodir_path) == 0 then
-- 	vim.fn.mkdir(undodir_path, "p") -- Create if not exists
-- end
--
-- -- Behavior Settings
-- vim.opt.errorbells = false -- Disable error sounds
-- vim.opt.backspace = "indent,eol,start" -- Make backspace behave naturally
-- vim.opt.autochdir = false -- Don't change directory automatically
-- vim.opt.iskeyword:append("-") -- Treat dash as part of a word
-- vim.opt.path:append("**") -- Search into subfolders with `gf`
-- vim.opt.selection = "inclusive" -- Use inclusive selection
-- vim.opt.mouse = "a" -- Enable mouse support
-- vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
-- vim.opt.modifiable = true -- Allow editing buffers
-- vim.opt.encoding = "UTF-8" -- Use UTF-8 encoding
-- vim.opt.wildmenu = true -- Enable command-line completion menu
-- vim.opt.wildmode = "longest:full,full" -- Completion mode for command-line
-- vim.opt.wildignorecase = true -- Case-insensitive tab completion in commands
--
-- -- Cursor Settings
-- vim.opt.guicursor = {
-- 	"n-v-c:block", -- Normal, Visual, Command-line
-- 	"i-ci-ve:block", -- Insert, Command-line Insert, Visual-exclusive
-- 	"r-cr:hor20", -- Replace, Command-line Replace
-- 	"o:hor50", -- Operator-pending
-- 	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking & highlight groups
-- 	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch mode
-- }
--
-- -- Folding Settings
-- vim.opt.foldmethod = "expr" -- Use expression for folding
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
-- vim.opt.foldlevel = 99 -- Keep all folds open by default
--
-- -- Split Behavior
-- vim.opt.splitbelow = true -- Horizontal splits open below
-- vim.opt.splitright = true -- Vertical splits open to the right
