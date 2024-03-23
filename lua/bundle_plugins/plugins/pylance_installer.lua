return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = {
        "lua:bundle_plugins/custom-registry",
        "github:mason-org/mason-registry",
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    -- init = function(plugin) require("astronvim.utils").load_plugin_with_func("mason.nvim", plugin.name) end,
    ft = "python",
    opts = {
      ensure_installed = {
        { "pylance", version = "2023.12.101" }, -- last known working version
      },
    },
    config = function(_, opts)
      local mason_tool_installer = require "mason-tool-installer"
      mason_tool_installer.setup(opts)
      mason_tool_installer.run_on_start()
    end,
  },
}
