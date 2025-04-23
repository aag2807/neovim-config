return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup(require "configs.telescope")
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
    event = "VimEnter"
  },

  {
    "wstucco/c3.nvim",
    config = function()
      require("c3")
    end,
    lazy = false,
    event = "VimEnter"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "ruby",
          "php",
          "lua",
          "vim",
          "vimdoc",
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "yaml",
          "markdown",
          "bash",
          "python",
          "rust",
          "zig",
          "odin",
          "c_sharp",
          "vue",
          "prisma",
          "graphql",
          "dockerfile",
          "sql"
        },
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
      })
    end,
  },

  -- Laravel specific plugins
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    config = function()
      require("laravel").setup()
    end,
  },

  -- C# specific plugins
  {
    "OmniSharp/omnisharp-vim",
    ft = "cs",
  },

  -- JavaScript/TypeScript specific plugins
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "volarjs/volar.js",
    ft = { "vue" },
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
  },

  -- Debugging support
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("configs.dap")
    end,
  },

  -- Language-specific plugins
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "php", "blade" },
  },

  {
    "fatih/vim-go",
    ft = "go",
    config = function()
      vim.g.go_fmt_command = "goimports"
    end,
  },

  {
    "vim-ruby/vim-ruby",
    ft = "ruby",
  },

  {
    "phpactor/phpactor",
    ft = "php",
  },

  {
    "ziglang/zig.vim",
    ft = "zig",
  },

  {
    "tetralux/odin.vim",
    ft = "odin",
  },
}
