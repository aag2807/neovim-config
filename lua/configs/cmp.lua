local cmp = require("cmp")
local luasnip = require("luasnip")

-- Helper function for super-tab behavior
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ 
      behavior = cmp.ConfirmBehavior.Replace,
      select = true 
    }),

    -- Super Tab behavior
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    -- Primary sources (high priority)
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    
    -- Secondary sources (medium priority)
    { name = "path" },
    { name = "npm", keyword_length = 4 }, -- npm packages
    { name = "treesitter" }, -- treesitter completions
    
    -- Tertiary sources (low priority)
    { name = "buffer", keyword_length = 3 },
    { name = "emoji" },
    { name = "nvim_lua" }, -- Neovim Lua API
    { name = "nvim_lsp_document_symbol" },
  }),

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      local kind_icons = {
        Text = " ",
        Method = "󰆧 ",
        Function = "󰊕 ",
        Constructor = " ",
        Field = "󰇽 ",
        Variable = "󰂡 ",
        Class = "󰠱 ",
        Interface = " ",
        Module = " ",
        Property = "󰜢 ",
        Unit = " ",
        Value = "󰎠 ",
        Enum = " ",
        Keyword = "󰌋 ",
        Snippet = " ",
        Color = "󰏘 ",
        File = "󰈙 ",
        Reference = " ",
        Folder = "󰉋 ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = " ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰅲 ",
      }

      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      
      -- Source names
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        npm = "[NPM]",
        emoji = "[Emoji]",
        nvim_lua = "[Lua]",
        nvim_lsp_signature_help = "[Signature]",
        treesitter = "[TS]",
        nvim_lsp_document_symbol = "[Symbol]",
      })[entry.source.name]
      
      return vim_item
    end,
  },

  experimental = {
    ghost_text = true, -- Shows preview of completion
  },
})

-- Setup for specific filetypes
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
})

-- Python-specific completion setup
cmp.setup.filetype('python', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'nvim_lsp_document_symbol' },
  })
})

-- JavaScript/TypeScript specific completion
cmp.setup.filetype({'javascript', 'typescript', 'javascriptreact', 'typescriptreact'}, {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'npm', keyword_length = 4 },
    { name = 'treesitter' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'emoji' },
  })
})

-- Command line completion
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- NPM completion setup for package.json files
require('cmp-npm').setup({})