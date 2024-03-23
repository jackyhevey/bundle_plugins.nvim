return {
  {
    "nat-418/boole.nvim",
    lazy = true,
    keys = {
      "<C-a>",
      "<C-x>",
    },
    config = function()
      require("boole").setup {
        mappings = {
          increment = "<C-a>",
          decrement = "<C-x>",
        },
        -- User defined loops
        additions = {
          { "Foo", "Bar" },
          { "tic", "tac", "toe" },
        },
        allow_caps_additions = {
          { "enable", "disable" },
          -- enable → disable
          -- Enable → Disable
          -- ENABLE → DISABLE
        },
      }
    end,
  },
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- local maps = { n = {} }
      -- maps.n["gs"] = { desc = "Surround" }
      -- require("astronvim.utils").set_mappings(maps)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Change surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsc", -- change surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    "folke/flash.nvim",
    -- event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      {
        "S",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "codota/tabnine-nvim",
    main = "tabnine",
    enabled = vim.loop.os_uname().sysname ~= "Linux",
    build = vim.loop.os_uname().sysname == "Windows_NT" and "powershell.exe -file .\\dl_binaries.ps1"
      or "./dl_binaries.sh",
    cmd = { "TabnineStatus", "TabnineDisable", "TabnineEnable", "TabnineToggle" },
    event = "InsertEnter",
    opts = { accept_keymap = "<C-e>" },
  },
  {
    -- tab key to move cursor cross chars
    "lilibyte/tabhula.nvim",
    --tabout in vscode
    event = "InsertEnter",
    opts = {},
  },
  {
    "johmsalas/text-case.nvim",
    lazy = true,
    keys = {
      {
        mode = { "n", "v" },
        "gat",
        function() require("textcase").operator "to_title_case" end,
        desc = "word title_case",
      },
    },
    config = function() require("textcase").setup {} end,
  },
  {
    "kana/vim-textobj-entire",
    lazy = true,
    keys = {
      { "ie", mode = { "o", "v" } },
      { "ae", mode = { "o", "v" } },
    },
    dependencies = {
      "kana/vim-textobj-user",
    },
  },
  {
    "yianwillis/vimcdoc",
    init = function() vim.o.helplang = "cn" end,
    lazy = true,
    build = 'sh vimcdoc.sh -i && python3 -c "$(curl -fsSL https://gitee.com/hevey88/a4_user/raw/main/utils/vimdoc_install_mac.py)"',
  },
  -- { "karb94/neoscroll.nvim", event = "VeryLazy", opts = {} },
}
