return {
  {
    "keaising/im-select.nvim",
    main = "im_select",
    build = '/bin/bash -c "$(curl -fsSL https://gitee.com/hevey88/im-select/raw/master/install_mac.sh)"',
    enabled = vim.fn.has "mac" == 1,
    event = "VimEnter",
    opts = {
      set_previous_events = {},
      -- set_default_events = { "VimEnter", "InsertLeave", "CmdlineLeave" }
    },
  },
  {
    "yianwillis/vimcdoc",
    init = function() vim.o.helplang = "cn" end,
    lazy = true,
    build = 'sh vimcdoc.sh -i && python3 -c "$(curl -fsSL https://gitee.com/hevey88/a4_user/raw/main/utils/vimdoc_install_mac.py)"',
  },
}
