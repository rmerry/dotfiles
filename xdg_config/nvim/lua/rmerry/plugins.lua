--require "paq" {
--  "savq/paq-nvim"; -- Let Paq manage itself

--  -- Completion
--  "hrsh7th/nvim-cmp";
--  "hrsh7th/cmp-buffer";
--  "hrsh7th/cmp-path";
--  "hrsh7th/cmp-nvim-lua";
--  "hrsh7th/cmp-nvim-lsp";

--  -- Colour Schemes
--  "norcalli/nvim-colorizer.lua"; -- Colour codes such as #00ff00 appear with the appropriate background colour.
--  "tjdevries/colorbuddy.vim";
--  "tjdevries/gruvbuddy.nvim";
--  "nvim-lua/plenary.nvim";
--  "Mofiqul/vscode.nvim";

--  -- Editor Config
--  "editorconfig/editorconfig-vim";

--  -- File Browsing
--  "tpope/vim-vinegar";
--  "nvim-telescope/telescope.nvim";
--  "nvim-lua/plenary.nvim";
--  "kyazdani42/nvim-web-devicons"; -- for file icons
--  --"kyazdani42/nvim-tree.lua";

--  -- LSP
--  "neovim/nvim-lspconfig";
--  "nvim-lua/lsp-status.nvim";
--  "onsails/diaglist.nvim";

--  -- Git
--  "tpope/vim-fugitive";

--  -- Go
--  "fatih/vim-go";

--  -- GraphQL
--  "jparise/vim-graphql";

--  -- Programming Productivity
--  "tpope/vim-commentary";
--  "radenling/vim-dispatch-neovim"; -- neovim dispatch adapter and dispatch.
--  "tpope/vim-dispatch";

--  -- Status Bar
--  "tjdevries/express_line.nvim"; -- Status bar.
--  "nvim-lua/plenary.nvim";

--  -- Tab Bar
--  "mkitt/tabline.vim";

--  -- Treesitter
--  {"nvim-treesitter/nvim-treesitter",run = vim.cmd[["TSUpdate"]]};

--  -- Misc
--  {"glacambre/firenvim", run = vim.fn['firenvim#install']};
--  "lukas-reineke/indent-blankline.nvim";
--}

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Colour Schemes
  use 'norcalli/nvim-colorizer.lua' -- Colour codes such as #00ff00 appear with the appropriate background colour.
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'Mofiqul/vscode.nvim'
  
  -- Editor Config
  use 'editorconfig/editorconfig-vim'
  
  -- File Browsing
  use 'tpope/vim-vinegar'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  --"kyazdani42/nvim-tree.lua";
  
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'onsails/diaglist.nvim'
  
  -- Git
  use 'tpope/vim-fugitive'
  
  -- Go
  use 'fatih/vim-go'
  
  -- GraphQL
  use 'jparise/vim-graphql'
  
  -- Programming Productivity
  use 'tpope/vim-commentary'
  use 'radenling/vim-dispatch-neovim' -- neovim dispatch adapter and dispatch.
  use 'tpope/vim-dispatch'
  
  -- Status Bar
  use 'tjdevries/express_line.nvim' -- Status bar.
  use 'nvim-lua/plenary.nvim'
  
  -- Tab Bar
  use 'mkitt/tabline.vim'
  
  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
