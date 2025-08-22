require("nvchad.configs.lspconfig").defaults()

local servers = { 
  "html", "cssls", "ts_ls", "eslint", "jsonls", 
  "yamlls", "tailwindcss", "volar", "angularls", "svelte"
}
vim.lsp.enable(servers)

local lspconfig = require('lspconfig')

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

-- Helper function to find Python path
local function get_python_path()
  local cwd = vim.fn.getcwd()
  local venv_paths = {
    cwd .. "/env/Scripts/python.exe", -- Windows
    cwd .. "/env/bin/python",         -- Linux/Mac
    cwd .. "/.venv/Scripts/python.exe", -- Windows
    cwd .. "/.venv/bin/python",       -- Linux/Mac
    cwd .. "/venv/Scripts/python.exe", -- Windows
    cwd .. "/venv/bin/python",        -- Linux/Mac
  }
  
  for _, path in ipairs(venv_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  
  -- Fall back to global python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

-- Python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
      },
    }
  },
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path()
  end,
})

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx"
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

-- ESLint
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
})

-- Vue (using new volar setup to avoid deprecation warning)
lspconfig.volar.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "vue" },
  init_options = {
    vue = {
      hybridMode = false,
    }
  }
})

-- Angular
lspconfig.angularls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  root_dir = lspconfig.util.root_pattern("angular.json", "project.json")
})

-- Svelte
lspconfig.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "svelte" }
})

-- JSON
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    }
  }
})

-- YAML
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    }
  }
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact", 
    "typescript", "typescriptreact", "vue", "svelte"
  }
})


