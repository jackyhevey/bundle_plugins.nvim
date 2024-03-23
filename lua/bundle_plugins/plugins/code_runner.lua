local prefix = "<leader>r"
-- local maps = { n = {} }
-- local icon = vim.g.icons_enabled and "󰁕 " or ""
-- maps.n[prefix] = { desc = icon .. "RunCode" }
-- require("astronvim.utils").set_mappings(maps)

return {
  "CRAG666/code_runner.nvim",
  event = "User AstroFile",
  keys = {
    { mode = { "n", "v" }, "<leader>rf", "<cmd>RunFile<CR>", desc = "RunFile" },
    { mode = { "n", "v" }, "<leader>rc", "<cmd>wincmd j | RunClose<CR>", desc = "RunClose" },
  },
  opts = {
    focus = false,
    filetype = {
      python = "python3 -u",
      lua = "lua",
    },
  },
}
