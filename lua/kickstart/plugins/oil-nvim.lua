return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      win_options = {
        -- Show path from home dir (~) in the winbar
        winbar = '%!v:lua._G.oil_home_path()',
      },
    },
    config = function(_, opts)
      -- Global helper to return path from home
      _G.oil_home_path = function()
        local dir = require('oil').get_current_dir()
        if not dir then
          return ''
        end
        -- Replace $HOME with ~
        dir = dir:gsub(vim.fn.getenv 'HOME', '~')
        return dir
      end

      require('oil').setup(opts)
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
