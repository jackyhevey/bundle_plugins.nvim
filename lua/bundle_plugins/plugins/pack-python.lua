return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "ruff_lsp")
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ruff_lsp = {
          filetypes = { "python" },
          root_dir = function(...)
            local util = require "lspconfig.util"
            return util.find_git_ancestor(...)
              or util.root_pattern(unpack {
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                "pyrightconfig.json",
              })(...)
          end,
          cmd = { "ruff-lsp" },
          single_file_support = true,
          init_options = {
            settings = {
              lint = { enable = false },
              -- organizeImports = false,
            },
          },
        },
      })
    end,
  },
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
