-- CORE SETTINGS {{{
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.background = "dark"
-- }}}

-- CORE MAPPINGS {{{
vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move highlighted blocks up and down.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z") -- Key you cursor in the same spot when using J to join lines.
vim.keymap.set("n", "n", "nzzzv") -- Key your search terms in the middle (vertically).
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", '"_dP') -- Paste over a highlighted text without clobbering the buffer.

vim.g.mapleader = ","
-- }}}

-- PLUGINS
--
vim.pack.add({
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- required by telescope and more
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = '0.1.8' },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/fatih/vim-go.git"},
	{ src = "https://github.com/catppuccin/nvim"},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{ src = "https://github.com/tpope/vim-commentary"},
	{ src = "https://github.com/tpope/vim-unimpaired"},
	{ src = "https://github.com/tpope/vim-fugitive"},
	{ src = "https://github.com/ThePrimeagen/harpoon"},
	{ src = "https://github.com/folke/which-key.nvim"},
	{ src = "https://github.com/nvim-tree/nvim-web-devicons"}, -- used by telescope(optional), which-key (optional)
})

-- KEYBINDINGS via Which-Key
-- 
local wk = require("which-key")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local builtin = require("telescope.builtin")

wk.add({
	-- Harpoon
  { "<leader>h", group = "⇁ Harpoon" },
  { "<leader>ha", mark.add_file, desc = "(a)dd", mode = "n" },
  { "<leader>hm", ui.toggle_quick_menu, desc = "(m)enu", mode = "n" },
  { "<Leader>ha", mark.add_file, desc = "(a)dd" },
  { "<Leader>hm", ui.toggle_quick_menu, desc = "(m)enu" },
  { "<Leader>hn", ui.nav_next, desc = "(n)ext file" },
  { "<Leader>hp", ui.nav_prev, desc = "(p)revious file" },
  { "<Leader>h1", function() ui.nav_file(1) end, desc = "(1)st file" },
  { "<Leader>h2", function() ui.nav_file(2) end, desc = "(2)nd file" },
  { "<Leader>h3", function() ui.nav_file(3) end, desc = "(3)rd file" },
  { "<Leader>h4", function() ui.nav_file(4) end, desc = "(4)th file" },

	-- Telescope
  { "<leader>f", group = "Telescope" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find (f)ile", mode = "n" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find (b)uffers", mode = "n" },
  { "<leader>fM", builtin.oldfiles,  desc = "Find RECENT Files" },
  { "<leader>fm", builtin.man_pages,  desc = "Find MAN page" },
  { "<leader>fh", builtin.help_tags,  desc = "Find HELP" },
  { "<leader>fw", builtin.grep_string,  desc = "Find WORD under cursor" },
  { "<leader>fS", builtin.lsp_dynamic_workspace_symbols,  desc = "Find (S)ymbols" },
  { "<leader>fs", builtin.live_grep,  desc = "Find (s)TRING" },
  { "<leader>fr", builtin.lsp_incoming_calls,  desc = "Find (r)eferences incomming calls string under cursor" },
  { "<leader>fo", builtin.lsp_outgoing_calls,  desc = "Find references to (o)utgoing calls of string under cursor" },
  { "<leader>rd", builtin.lsp_document_symbols,  desc = "Find (d)ocument symbols grep" },
  { "<leader>fa", builtin.lsp_workspace_symbols,  desc = "Find (a)ll references" },
  { "<leader>fr", builtin.lsp_references,  desc = "Find (r)references to  word under cursor" },
  { "<leader>gd", builtin.lsp_declaration,  desc = "Goto declaration of word under cursor" },
  { "<leader>gi", builtin.lsp_implementations,  desc = "GOTO implementation (of word under cursor)" },
})

-- PLUGIN: NVIM-CMP
-- 
local cmp = require'cmp'
cmp.setup({	
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},

	-- Enable luasnip to handle snippet expansion for nvim-cmp
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})
cmp.setup.cmdline('/', {
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
	{
	  name = 'cmdline',
	  option = {
		ignore_cmds = {} -- default is: `ignore_cmds = { 'Man', '!' }`
	  }
	}
  })
})

-- PLUGIN: NVIM.LSPCONFIG
--
vim.lsp.enable('gopls')
vim.lsp.enable('zls')
vim.lsp.enable('csharp_ls')

-- PLUGIN: TELESCOPE.NVIM
--
require('telescope').setup({
	pickers = {
		find_files = {
			-- `hidden = true` will still show inside of '.git/` as it's not in '.gitignore`
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})

-- PLUGIN: NVIM-TREESITTER
--
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- COLOURSCHEME
--
vim.cmd.colorscheme("catppuccin")
