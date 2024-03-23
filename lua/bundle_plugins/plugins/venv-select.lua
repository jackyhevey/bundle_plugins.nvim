return {
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
        local util = require "lspconfig/util"
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
}
