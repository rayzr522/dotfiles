---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    mappings = {
      n = {
        ["<leader>Nf"] = { function() require("neogen").generate({ type = "func" }) end, desc = "Generate function annotation" },
        ["<leader>Nc"] = { function() require("neogen").generate({ type = "class" }) end, desc = "Generate class annotation" },
        ["<leader>Nt"] = { function() require("neogen").generate({ type = "type" }) end, desc = "Generate type annotation" },
      }
    },
  },
}
