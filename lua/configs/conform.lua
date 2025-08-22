local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    
    -- Web technologies
    html = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    
    -- JavaScript/TypeScript
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    
    -- Vue/Svelte
    vue = { "prettierd", "prettier" },
    svelte = { "prettierd", "prettier" },
    
    -- Config files
    json = { "prettierd", "prettier" },
    jsonc = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    
    -- Python
    python = { "isort", "black" },
    
    -- Markdown
    markdown = { "prettierd", "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
