return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = function(_, opts)
      -- local win_height = vim.fn.winheight(0)
      local cmd_out = vim.fn.system "which python3.11"
      local cmd_path = string.gsub(cmd_out, "\n", "")
      local opt = require("bundle_plugins").extend_tbl(opts, {
        options = {
          -- first key is the type of option `vim.<first_key>`
          opt = {
            relativenumber = true, -- sets `vim.opt.relativenumber`
            -- signcolumn = "auto", -- sets `vim.opt.relativenumber`
            number = false,
            -- spellfile = vim.fn.stdpath "config" .. "/lua/user/spell/en.utf8.add",
            -- thesaurus = vim.fn.stdpath "config" .. "/lua/user/spell/mthesaur.txt",
            -- helplang = "cn",
            paste = false,
            scrolloff = 5,
            -- scrolloff = math.floor((win_height - 1) / 2),
            -- sidescrolloff = math.floor((win_height - 1) / 2),
          },
          g = {
            transparent_background = true,
            python_host_prog = cmd_path,
            python3_host_prog = cmd_path,
            -- icons_enabled = false,
            -- set global `vim.g` settings here
          },
        },
        -- colorscheme = "catppuccin-mocha",
        -- todo not working?
        diagnostics = {
          underline = true,
          virtual_text = {
            spacing = 5,
            severity_limit = "WARN",
            severity = {
              min = vim.diagnostic.severity.INFO,
            },
          },
          signs = {
            severity = {
              min = vim.diagnostic.severity.INFO,
            },
          },
          update_in_insert = false,
        },
        -- modify core features of AstroNvim
        features = {
          large_buf = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
          autopairs = true, -- enable autopairs at start
          cmp = true, -- enable completion at start
          highlighturl = true, -- highlight URLs at start
          notifications = true, -- enable notifications at start
        },
        autocmds = {
          -- auto_spell = {
          --   {
          --     event = "FileType",
          --     desc = "Enable wrap and spell for text like documents",
          --     pattern = { "gitcommit", "markdown", "text", "plaintex" },
          --     callback = function()
          --       vim.opt_local.wrap = true
          --       vim.opt_local.spell = true
          --     end,
          --   },
          -- },
          -- auto_hide_tabline = {
          --   {
          --     event = "User",
          --     desc = "Auto hide tabline",
          --     pattern = "AstroBufsUpdated",
          --     callback = function()
          --       local new_showtabline = #vim.t.bufs > 1 and 2 or 1
          --       if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
          --     end,
          --   },
          -- },
          -- auto_resession = {
          --   {
          --     event = "VimEnter",
          --     desc = "Restore session on open",
          --     callback = function()
          --       if require("astrocore").is_available "resession.nvim" then
          --         local resession = require "resession"
          --         -- Only load the session if nvim was started with no args
          --         if vim.fn.argc(-1) == 0 then
          --           -- Save these to a different directory, so our manual sessions don't get polluted
          --           resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
          --           vim.cmd.doautoall "BufReadPre"
          --         end
          --       end
          --     end,
          --   },
          -- },
          auto_conceallevel_for_json = {
            {
              event = "FileType",
              desc = "Fix conceallevel for json files",
              pattern = { "json", "jsonc" },
              callback = function()
                vim.wo.spell = false
                vim.wo.conceallevel = 0
              end,
            },
          },
          -- auto_select_virtualenv = {
          --   {
          --     event = "FileType",
          --     desc = "Auto select virtualenv Nvim open",
          --     pattern = "python",
          --     callback = function()
          --       local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
          --       if venv ~= "" then require("venv-selector").retrieve_from_cache() end
          --     end,
          --     once = true,
          --   },
          -- },
        },
        -- mappings = require("mappings").mappings(opts.mappings),
      })
      return opt
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      local status_utils = status.utils
      opts.statusline[1] = status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
        hl = { fg = "#111111", bold = true },
      }
      opts.statusline[3] =
        status.component.file_info { filetype = {}, filename = false, file_modified = { padding = { left = 1 } } }
      opts.statusline[5] =
        status.component.builder(status_utils.setup_providers({}, { "ERROR", "WARN", "INFO" }, function(p_opts, p)
          local out = status_utils.build_provider(p_opts, p)
          if out then
            out.provider = "diagnostics"
            out.opts.severity = p
            if out.hl == nil then out.hl = { fg = "diag_" .. p } end
          end
          return out
        end))
      return opts
    end,
  },
}
