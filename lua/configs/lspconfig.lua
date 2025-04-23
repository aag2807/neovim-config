-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Language servers configuration
local lspconfig = require('lspconfig')

-- C/C++
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Go
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Ruby
lspconfig.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- PHP/Laravel
lspconfig.phpactor.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    ["language_server_phpstan.enabled"] = true,
    ["language_server_psalm.enabled"] = true,
  },
}

-- C#
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "dotnet", "C:/Users/user/.omnisharp/OmniSharp.dll" },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
}

-- TypeScript/JavaScript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  },
}

-- Vue
lspconfig.volar.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

-- Deno
lspconfig.denols.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

-- Angular
lspconfig.angularls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_new_config = function(new_config)
    new_config.cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" }
  end,
}

-- Zig
lspconfig.zls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Odin
lspconfig.ols.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "C:\\Users\\user\\Documents\\ols\\ols\\ols.exe" },
}

-- C3
lspconfig.c3_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Lua
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

