require "paq" {
  -- Completion
  "hrsh7th/nvim-cmp";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-path";
  "hrsh7th/cmp-nvim-lua";
  "hrsh7th/cmp-nvim-lsp";

  -- Colour Schemes
  "norcalli/nvim-colorizer.lua"; -- Colour codes such as #00ff00 appear with the appropriate background colour.
  "tjdevries/colorbuddy.vim";
  "tjdevries/gruvbuddy.nvim";
  "nvim-lua/plenary.nvim";

  -- Editor Config
  "editorconfig/editorconfig-vim";

  -- File Browsing
  "tpope/vim-vinegar";
  "nvim-telescope/telescope.nvim";
  "nvim-lua/plenary.nvim";

  -- LSP
  "neovim/nvim-lspconfig";
  "nvim-lua/lsp-status.nvim";
  "onsails/diaglist.nvim";

  -- Git
  "tpope/vim-fugitive";

  -- Go
  "fatih/vim-go";

  -- GraphQL
  "jparise/vim-graphql";

  -- Programming Productivity
  "tpope/vim-commentary";
  "radenling/vim-dispatch-neovim"; -- neovim dispatch adapter and dispatch.
  "tpope/vim-dispatch";

  -- Status Bar
  "tjdevries/express_line.nvim"; -- Status bar.
  "nvim-lua/plenary.nvim";

  -- Treesitter
  {"nvim-treesitter/nvim-treesitter",run = vim.cmd[["TSUpdate"]]};

  -- Misc
  {"glacambre/firenvim", run = vim.fn['firenvim#install']};
}
