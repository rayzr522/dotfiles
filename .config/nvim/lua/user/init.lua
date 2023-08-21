local config = {
  colorscheme = "tokyonight",
  plugins = {
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
  },
  lsp = {
    mappings = {
      n = {
        ["<leader>Nf"] = { function() require("neogen").generate({ type = "func" }) end, desc = "Generate function annotation" },
        ["<leader>Nc"] = { function() require("neogen").generate({ type = "class" }) end, desc = "Generate class annotation" },
        ["<leader>Nt"] = { function() require("neogen").generate({ type = "type" }) end, desc = "Generate type annotation" },
      }
    },
  },
}

return config
