return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      -- "nvimtools/none-ls-extras.nvim",
      -- "gbprod/none-ls-luacheck.nvim",
      -- "gbprod/none-ls-shellcheck.nvim",
    },
    opts = function(_, config)
      -- config variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- require("none-ls.formatting.autopep8").with { extra_args = { "--max-line-length", "120", "--ignore", "E701" } },
        -- require "none-ls.formatting.ruff_format",
        -- require "none-ls-luacheck.diagnostics.luacheck",
        -- require "none-ls-shellcheck.diagnostics", --bash_ls integration
        -- require "none-ls-shellcheck.code_actions",
        -- require "none-ls.formatting.ruff",
        -- null_ls.builtins.formatting.black.with { extra_args = { "--line-length", "120" } },
        null_ls.builtins.formatting.isort.with {
          extra_args = {
            "--case-sensitive",
            "--multi-line",
            "9",
            "--ls",
            "--treat-all-comment-as-code",
            "--lbi",
            "1",
          },
        },
        null_ls.builtins.diagnostics.selene.with {
          extra_args = {
            "--config",
            vim.fn.stdpath "data" .. "/lazy/bundle_plugins.nvim/selene.toml",
          },
        },
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.markdown-toc,
      }
      return config -- return final config table
    end,
    -- config = function() require("null-ls").register(require "none-ls-luacheck.diagnostics.luacheck") end,
  },
}
