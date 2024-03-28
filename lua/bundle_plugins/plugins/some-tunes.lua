return {
  {
    "L3MON4D3/LuaSnip",
    opts = function()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = "~/Library/Application Support/Code/User/snippets/",
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = function(_, opts) opts.map_bs = false end,
  },
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      opts.on_open = function() vim.cmd [[ silent! tunmap <C-h>]] end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      completion = {
        -- 自动选中第一条
        completeopt = "menu,menuone,noinsert",
      },
    },
  },
}
