require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4", -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  { import = "community" },
  { import = "plugins" },
    { "folke/tokyonight.nvim", },
    {
      "axelvc/template-string.nvim",
      ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      config = function()
        require("template-string").setup({})
      end
    },
    {
      "rayzr522/diagnostic-filter.nvim",
      ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      config = function()
        require('diagnostic-filter').setup({
          diagnostic_filters = {
            ["eslint_d"] = { "^Error: No ESLint configuration found in .*$" }
          }
        })
      end
    },
    {
      "danymat/neogen",
      config = function()
        require("neogen").setup({
          languages = {
            ["svelte"] = require("neogen.configurations.javascript")
          }
        })
      end
    },

} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "tokyonight", "astrodark", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
