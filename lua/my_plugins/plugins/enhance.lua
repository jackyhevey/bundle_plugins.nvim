return {
	{
		"codota/tabnine-nvim",
		main = "tabnine",
		enabled = vim.loop.os_uname().sysname ~= "Linux",
		build = vim.loop.os_uname().sysname == "Windows_NT" and "powershell.exe -file .\\dl_binaries.ps1"
			or "./dl_binaries.sh",
		cmd = { "TabnineStatus", "TabnineDisable", "TabnineEnable", "TabnineToggle" },
		event = "User AstroFile",
		opts = { accept_keymap = "<C-y>" },
	},
	{
		-- tab key to move cursor cross chars
		"lilibyte/tabhula.nvim",
		--tabout in vscode
		event = "InsertEnter",
		opts = {},
	},
	{
		"yianwillis/vimcdoc",
		lazy = true,
		build = 'sh vimcdoc.sh -i && python3 -c "$(curl -fsSL https://gitee.com/hevey88/a4_user/raw/main/utils/vimdoc_install_mac.py)"',
	},
	-- { "karb94/neoscroll.nvim", event = "VeryLazy", opts = {} },
}
