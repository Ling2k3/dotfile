require("nvim-treesitter.configs").setup({
   ensure_installed = { "lua", "vim", "go", "vimdoc", "query", "zig", "json", "editorconfig", "sql" },
   sync_install = false,
   auto_install = true,
   hightlight = {
      enable = true, },
   indent = {
      enable = true,
   },
   fold = {
      enable = true,
   },
   incremental_selection = { enable = true },
   textobjects = { enable = true },
})

local cmp = require("cmp")
cmp.setup({
   snippet = { expand = function(args)
         vim.fn["vsnip#anonymous"](args.body)
      end,
   },
   window = {},
   mapping = cmp.mapping.preset.insert({
      ["<C-c>"] = cmp.mapping.close(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      }),
   }),
   sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" },
   }, { { name = "buffer" } }),
})
require("mason").setup({})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.zls.setup({
   capabilities = capabilities,
})
lspconfig.lua_ls.setup({})
lspconfig.gopls.setup({
   capabilities = capabilities,
   cmd = { "gopls" },
   setting = {
      gopls = {
         completeUnimported = true,
         usePlaceholders = true,
         analyses = {
            unusedparam = true,
         },
         staticcheck = true,
         gofumpt = true,
      },
   },
})

require('Comment').setup()
