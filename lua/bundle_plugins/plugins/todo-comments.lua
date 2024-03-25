return {
  {
    "folke/todo-comments.nvim",
    opts = {},
    event = "BufReadPost",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  },
}
