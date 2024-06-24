---@type LazySpec
return {
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
}
