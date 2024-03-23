return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    keys = {
      {
        "<leader>fe",
        function() require("telescope").extensions.file_browser.file_browser {} end,
        desc = "File_browser",
      },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>fp", function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
    },
    opts = {},
  },
}
