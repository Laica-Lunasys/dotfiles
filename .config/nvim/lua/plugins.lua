local status, packer = pcall(require, "packer")

if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Theme
    -- use 'itchyny/lightline.vim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'tomasr/molokai'

    -- Utils
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'preservim/NERDTree'

    -- -> Auto fix trailing white-space
    use 'bronson/vim-trailing-whitespace'
    use 'windwp/nvim-autopairs'
    use 'norcalli/nvim-colorizer.lua'
    use 'alvan/vim-closetag'

    -- Completion
    use 'onsails/lspkind-nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'

    -- Git Support
    use 'dinhhuy258/git.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'kdheepak/lazygit.nvim'

    -- LSP
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hashicorp/terraform-ls',
    }

    -- -> formatters
    use 'MunifTanjim/prettier.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'

    use 'glepnir/lspsaga.nvim'
    use 'L3MON4D3/LuaSnip'

    -- -> treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    use {
        'windwp/nvim-ts-autotag',
        opt = true,
        requires = { { 'nvim-treesitter/nvim-treesitter' } },
        config = function() require('nvim-ts-autotag').setup() end,
    }

    -- Markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
end)
