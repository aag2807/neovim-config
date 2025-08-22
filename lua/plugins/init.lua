return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "pyright",
        "debugpy",
        "black",
        "isort",
        "flake8",
        
        -- JavaScript/TypeScript
        "typescript-language-server",
        "eslint-lsp",
        "prettierd",
        "js-debug-adapter",
        
        -- Vue
        "@vue/language-server",
        
        -- Angular
        "@angular/language-server",
        
        -- Svelte
        "svelte-language-server",
        
        -- Tailwind
        "tailwindcss-language-server",
        
        -- JSON
        "json-lsp",
        
        -- YAML
        "yaml-language-server",
        
        -- Dockerfile
        "dockerfile-language-server",
        
        -- Markdown
        "marksman"
      }
    }
  },
  {
    "you-n-g/jinja-engine.nvim",
    dependencies = {
    },
  }, 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "scss",
        "javascript", "typescript", "tsx",
        "vue", "svelte", "astro",
        "json", "jsonc", "yaml", "toml",
        "python", "go", "rust",
        "markdown", "markdown_inline",
        "dockerfile", "bash"
      },
    },
  },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require "configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },

  -- Schema store for JSON/YAML
  {
    "b0o/schemastore.nvim",
  },

  -- Additional useful plugins for JS/TS development
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "tsx", "jsx", "svelte", "astro"
    },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false
        }
      })
    end
  },

  -- Package info for package.json
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require('package-info').setup()
    end,
  },

  -- TypeScript utilities
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- Enhanced completion sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      -- JavaScript/TypeScript specific
      "David-Kunz/cmp-npm", -- npm package completion
      "hrsh7th/cmp-emoji", -- emoji completion
      -- Python specific
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "KadoBOT/cmp-plugins", -- plugin management
      "ray-x/cmp-treesitter", -- treesitter completions
    },
    config = function()
      require "configs.cmp"
    end,
  },

  -- Enhanced snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets", -- collection of snippets
      "molleweide/LuaSnip-snippets.nvim", -- more snippets
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },

  -- Python environment detection
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      name = {"venv", ".venv", "env", ".env"},
    },
    event = "VeryLazy",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
    },
  },

  -- Enhanced Telescope configuration
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "configs.telescope"
    end,
  },
}
