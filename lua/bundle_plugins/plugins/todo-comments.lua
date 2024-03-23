return {
  {
    "folke/todo-comments.nvim",
    opts = {},
    event = "BufEnter",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  },
}
