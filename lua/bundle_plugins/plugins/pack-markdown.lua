return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("bundle_plugins").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("bundle_plugins").list_insert_unique(opts.ensure_installed, { "marksman" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("bundle_plugins").list_insert_unique(opts.ensure_installed, { "prettierd" })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      {
        mode = { "n", "v" },
        "<leader>ze",
        "<cmd>MarkdownPreview<CR>",
        desc = "Open Markdown Preview",
      },
    },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- {
  --   "TobinPalmer/pastify.nvim",
  --   cmd = { "Pastify" },
  --   opts = {
  --     absolute_path = false,
  --     apikey = "",
  --     local_path = "/assets/imgs/",
  --     save = "local",
  --   },
  -- },
}
