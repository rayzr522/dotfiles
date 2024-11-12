---@type LazySpec
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        "ts_ls",
        "volar",
        "jsonls",
        "yamlls",
        "emmet_language_server",
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "biome",
        "prettier",
      })
    end,
  },
  {
    -- yoinked from https://github.com/OneOfOne/dotfiles/blob/master/.config/nvim/lua/plugins/code.lua
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls').builtins
      opts.sources = { --override lazyvim's default sources
        -- ts
        nls.formatting.biome.with({
          filetypes = {
            'javascript',
            'javascriptreact',
            'json',
            'jsonc',
            'typescript',
            'typescriptreact',
            'css',
            'vue',
          },
          -- args = {
          --   'check',
          --   '--write',
          --   '--unsafe',
          --   '--formatter-enabled=true',
          --   '--organize-imports-enabled=true',
          --   '--skip-errors',
          --   '--stdin-file-path=$FILENAME',
          -- },
          condition = function(utils)
            return utils.root_has_file({ "biome.json" })
          end,
        }),
        nls.formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file({ ".prettierrc" })
          end,
        }),
      }
      -- opts.debug = true
      return opts
    end,
  },
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   -- overrides `require("mason-nvim-dap").setup(...)`
  --   opts = function(_, opts)
  --     -- add more things to the ensure_installed table protecting against community packs modifying it
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
  --       "python",
  --       -- add more arguments for adding more debuggers
  --     })
  --   end,
  -- },
}
