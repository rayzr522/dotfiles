---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    -- opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
    --   n = {
    --     ["<leader>Nf"] = { function() require("neogen").generate({ type = "func" }) end, desc = "Generate function annotation" },
    --     ["<leader>Nc"] = { function() require("neogen").generate({ type = "class" }) end, desc = "Generate class annotation" },
    --     ["<leader>Nt"] = { function() require("neogen").generate({ type = "type" }) end, desc = "Generate type annotation" },
    --   }
    -- })
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      ts_ls = {
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = require("mason-registry").get_package("vue-language-server"):get_install_path() .. "/node_modules/@vue/language-server",
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
      },
    })
  end
}
