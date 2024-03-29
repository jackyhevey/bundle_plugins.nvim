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
  {
    "linux-cultist/venv-selector.nvim",
    keys = {
      { "<leader>lv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
      { "<leader>lV", "<cmd>VenvSelectCurrent<cr>", desc = "Show Current VirtualEnv" },
    },
    ft = "python",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Auto select virtualenv Nvim open",
        pattern = "python",
        callback = function()
          local util = require "lspconfig.util"
          local root_files = {
            ".git",
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
            "main.py",
            ".neoconf.json",
          }
          local venv = util.root_pattern(unpack(root_files))
          if venv ~= "" then require("venv-selector").retrieve_from_cache() end
        end,
        once = true,
      })
      if vim.fn.executable "conda" == 1 then
        local cmd_out = vim.fn.system "conda info --base"
        local base_path = string.gsub(cmd_out, "\n", "")
        local env_path = base_path .. "/envs"
        opts.anaconda_base_path = base_path
        opts.anaconda_envs_path = env_path
      end
      opts.name = { "venv", ".venv" }
      return opts
    end,
  },
}
