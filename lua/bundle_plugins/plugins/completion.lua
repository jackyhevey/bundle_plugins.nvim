return {
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
}
