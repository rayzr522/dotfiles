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

vim.api.nvim_create_autocmd("LspAttach", {
  ---@param ev { buf: number, data: { client_id: number }}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "tsserver" then
      local is_deno = not (vim.fn.findfile("deno.json", ".;") == '')
      if is_deno then client.stop() end
    end
  end,
})

return config
