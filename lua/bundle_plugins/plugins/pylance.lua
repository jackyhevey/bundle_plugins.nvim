local lsp_util = require "vim.lsp.util"

local function extract_method()
  local range_params = lsp_util.make_given_range_params()
  local arguments = { vim.uri_from_bufnr(0):gsub("file://", ""), range_params.range }
  print "extract_method"
  local params = {
    command = "pylance.extractMethod",
    arguments = arguments,
  }
  vim.lsp.buf.execute_command(params)
end

local function extract_variable()
  local range_params = lsp_util.make_given_range_params()
  local arguments = { vim.uri_from_bufnr(0):gsub("file://", ""), range_params.range }
  print "extract_variable"
  local params = {
    command = "pylance.extractVarible",
    arguments = arguments,
  }
  vim.lsp.buf.execute_command(params)
end

local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local function on_workspace_executecommand(err, result, ctx)
  if ctx.params.command:match "WithRename" then
    ctx.params.command = ctx.params.command:gsub("WithRename", "")
    print(vim.inspect(ctx.params))
    vim.lsp.buf.execute_command(ctx.params)
  end
  if result then
    if result.label == "Extract Method" then
      local old_value = result.data.newSymbolName
      local file = vim.tbl_keys(result.edits.changes)[1]
      local range = result.edits.changes[file][1].range.start
      local params = { textDocument = { uri = file }, position = range }
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local bufnr = ctx.bufnr
      local prompt_opts = {
        prompt = "New Method Name: ",
        default = old_value,
      }
      if not old_value:find "new_var" then range.character = range.character + 5 end
      vim.ui.input(prompt_opts, function(input)
        if not input or #input == 0 then return end
        params.newName = input
        local handler = client.handlers["textDocument/rename"] or vim.lsp.handlers["textDocument/rename"]
        client.request("textDocument/rename", params, handler, bufnr)
      end)
    end
  end
end
return {
  { "microsoft/python-type-stubs", lazy = true },
  { "pandas-dev/pandas-stubs", lazy = true },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "pylance")
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        pylance = {
          filetypes = { "python" },
          root_dir = function(...)
            local util = require "lspconfig.util"
            return util.find_git_ancestor(...)
              or util.root_pattern(unpack {
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                "pyrightconfig.json",
              })(...)
          end,
          cmd = { "pylance", "--stdio" },
          single_file_support = true,
          before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath "python" end,
          settings = {
            python = {
              analysis = {
                -- typeCheckingMode = "off",
                -- ignore = { "*" },
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                completeFunctionParens = true,
                indexing = true,
                inlayHints = false,
                stubPath = vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
                extraPaths = {
                  vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
                  vim.fn.stdpath "data" .. "/lazy/pandas-stubs/pandas-stubs",
                },
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "none",
                  reportUnusedFunction = "none",
                  reportUnusedVariable = "none",
                  reportGeneralTypeIssues = "none",
                  reportOptionalMemberAccess = "none",
                  reportOptionalSubscript = "none",
                  reportPrivateImportUsage = "none",
                },
              },
            },
          },
          handlers = {
            ["workspace/executeCommand"] = on_workspace_executecommand,
          },
          commands = {
            PylanceExtractMethod = {
              extract_method,
              description = "Extract Method",
            },
            PylanceExtractVarible = {
              extract_variable,
              description = "Extract Variable",
            },
            PylanceOrganizeImports = {
              organize_imports,
              description = "Organize Imports",
            },
          },
          docs = {
            description = "https://github.com/microsoft/pylance-release\n\n`pylance`, Fast, feature-rich language support for Python",
          },
        },
      })
    end,
  },
}
