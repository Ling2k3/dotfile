local vim = vim
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug('navarasu/onedark.nvim')
Plug('Mofiqul/vscode.nvim')

Plug("nvim-neo-tree/neo-tree.nvim")
Plug("MunifTanjim/nui.nvim")
Plug("nvim-lua/plenary.nvim")
Plug('nvim-tree/nvim-web-devicons')
Plug("nvim-treesitter/nvim-treesitter")
Plug("nvim-treesitter/nvim-treesitter-textobjects")
Plug("nvim-lualine/lualine.nvim")


Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")
Plug("windwp/nvim-ts-autotag")
Plug("windwp/nvim-autopairs")
Plug("neovim/nvim-lspconfig")

Plug('jose-elias-alvarez/null-ls.nvim')

Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

Plug(  "williamboman/mason-lspconfig.nvim")
Plug('williamboman/mason.nvim')

Plug('ggandor/lightspeed.nvim')

Plug('xiyaowong/transparent.nvim')

Plug('dgagn/diagflow.nvim')




vim.call("plug#end")
