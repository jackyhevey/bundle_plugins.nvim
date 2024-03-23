return {
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
}
