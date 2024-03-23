return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("bundle_plugins").list_insert_unique(opts.ensure_installed, {
        "ruff_lsp",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("bundle_plugins").list_insert_unique(opts.ensure_installed, { "python", "toml" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("bundle_plugins").list_insert_unique(opts.ensure_installed, { "isort" })
    end,
  },
}
