vim.g.mapleader = "," -- Good idea to do this before loading plugins.

require "rmerry.init_paq" -- Make sure paq is installed.
require "rmerry.plugins"
require "rmerry.lsp" -- Neovim builtin LSP configuration.
require "rmerry.treesitter" -- Neovim builtin LSP configuration.
