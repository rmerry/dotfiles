-- CORE SETTINGS
--
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

-- CORE MAPPINGS
--
vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move highlighted blocks up and down.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z") -- Key you cursor in the same spot when using J to join lines.
vim.keymap.set("n", "n", "nzzzv") -- Key your search terms in the middle (vertically).
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", '"_dP') -- Paste over a highlighted text without clobbering the buffer.

vim.g.mapleader = ","

-- INSTALL LAZY.NVIM
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- INITIALISE LAZY.NVIM & PLUGINS
--
require("lazy").setup({
	change_detection = {
		notify = false,
	},

	-----------PLUGIN: NVIM-CMP------------
	--
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			vim.opt.shortmess:append("c")

			local lspkind = require("lspkind")
			lspkind.init({})

			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "cody" },
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
		end,
	},

	-----------PLUGIN: everforest------------
	--
	-- {
	-- 	"https://github.com/sainnhe/everforest",
	-- 	name = "everforest",
	-- 	config = function()
	-- 		-- ef.setup({
	-- 		-- everforest_background = "soft",
	-- 		-- })
	-- 		--

	-- 		vim.cmd([[ colorscheme everforest ]])
	-- 	end,
	-- 	priority = 1000,
	-- },

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-----------PLUGIN: ROSE-PINE.NVIM------------
	--
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			-- vim.cmd([[ colorscheme rose-pine ]])

			local rp = require("rose-pine")

			rp.setup({
				--- @usage 'auto'|'main'|'moon'|'dawn'
				variant = "auto",
				--- @usage 'main'|'moon'|'dawn'
				dark_variant = "main",
				bold_vert_split = false,
				dim_nc_background = false,
				disable_background = false,
				disable_float_background = false,
				disable_italics = false,

				--- @usage string hex value or named color from rosepinetheme.com/palette
				groups = {
					background = "base",
					background_nc = "_experimental_nc",
					panel = "surface",
					panel_nc = "base",
					border = "highlight_med",
					comment = "muted",
					link = "iris",
					punctuation = "subtle",

					error = "love",
					hint = "iris",
					info = "foam",
					warn = "gold",

					headings = {
						h1 = "iris",
						h2 = "foam",
						h3 = "rose",
						h4 = "gold",
						h5 = "pine",
						h6 = "foam",
					},
					-- or set all headings at once
					-- headings = 'subtle'
				},

				-- Change specific vim highlight groups
				-- https://github.com/rose-pine/neovim/wiki/Recipes
				highlight_groups = {
					ColorColumn = { bg = "rose", blend = 10 },

					-- Blend colours against the "base" background
					CursorLine = { bg = "foam", blend = 10 },
					StatusLine = { fg = "love", bg = "love", blend = 5 },

					-- By default each group adds to the existing config.
					-- If you only want to set what is written in this config exactly,
					-- you can set the inherit option:
					Search = { bg = "gold", inherit = false },
				},
			})
		end,
		priority = 1000,
	},

	-----------PLUGIN: VIM-FUGITIVE------------
	---
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},

	-----------PLUGIN: GO.NVIM------------
	---
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		-- Install/update all binaries.
		build = ':lua require("go.install").update_all_sync()',

		config = function()
			local go = require("go")
			go.setup()

			-- Run gofmt + goimport on save
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end,
	},

	-----------PLUGIN: HARPOON------------
	---
	{
		"ThePrimeagen/harpoon",
		config = function()
			local ui = require("harpoon.ui")
			local mark = require("harpoon.mark")
			local wk = require("which-key")

			wk.add({
				{ "<leader>h", group = "𓐬 HARPOON" },
			})

			vim.keymap.set("n", "<Leader>ha", mark.add_file, { desc = "𓐬 HARPOON (a)dd" })
			vim.keymap.set("n", "<Leader>hm", ui.toggle_quick_menu, { desc = "𓐬 HARPOON (m)enu" })
			vim.keymap.set("n", "<Leader>hn", ui.nav_next, { desc = "𓐬 HARPOON (n)next file" })
			vim.keymap.set("n", "<Leader>hp", ui.nav_prev, { desc = "𓐬 HARPOON (p)revious file" })
			vim.keymap.set("n", "<Leader>h1", function()
				ui.nav_file(1)
			end, { desc = "𓐬 HARPOON (1)st file" })
			vim.keymap.set("n", "<Leader>h2", function()
				ui.nav_file(2)
			end, { desc = "𓐬 HARPOON (2)nd file" })
			vim.keymap.set("n", "<Leader>h3", function()
				ui.nav_file(3)
			end, { desc = "𓐬 HARPOON (3)rd file" })
			vim.keymap.set("n", "<Leader>h4", function()
				ui.nav_file(4)
			end, { desc = "𓐬 HARPOON (4)th file" })
		end,
	},

	-----------PLUGIN: NVIM.LSPCONFIG------------
	---
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
			-- Autoformatting
			"stevearc/conform.nvim",
			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("neodev").setup({
				library = {
					plugins = { "nvim-dap-ui" },
					types = true,
				},
			})

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				bashls = true,
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = false,
								compositeLiteralFields = false,
								compositeLiteralTypes = false,
								constantValues = false,
								functionTypeParameters = false,
								parameterNames = false,
								rangeVariableTypes = false,
							},
						},
					},
				},
				lua_ls = true,
				rust_analyzer = true,
				svelte = true,
				templ = true,
				cssls = true,
				zls = true,
				csharp_ls = true,

				-- Probably want to disable formatting for this lang server
				ts_ls = true,

				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				ocamllsp = {
					manual_install = true,
					settings = {
						codelens = { enable = true },
						inlayHints = { enable = true },
					},

					filetypes = {
						"ocaml",
						"ocaml.interface",
						"ocaml.menhir",
						"ocaml.cram",
					},

					-- TODO: Check if i still need the filtypes stuff i had before
				},

				lexical = {
					cmd = { "/home/tjdevries/.local/share/nvim/mason/bin/lexical", "server" },
					root_dir = require("lspconfig.util").root_pattern({ "mix.exs" }),
				},

				clangd = {
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					filetypes = { "c" },
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				"delve",
				-- "tailwind-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

					vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			-- Autoformatting Setup
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})
		end,
	},

	-----------PLUGIN: MINI.NVIM------------
	---
	{
		"echasnovski/mini.nvim",
		name = "mini.align",
		priority = 1000,
	},

	-----------PLUGIN: TELESCOPE.NVIM------------
	---
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		priority = 1000,
		lazy = false,
		config = function()
			local telescope = require("telescope")
			local telescopeConfig = require("telescope.config")

			local wk = require("which-key")
			wk.add({
				{ "<leader>f", group = "🔭 TELESCOPE" },
			})

			-- Clone the default Telescope configuration and change the vimgrep_argumens
			-- variable to allow us to search in hidden files (but not in `.git/`)
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
			table.insert(vimgrep_arguments, "--hidden") -- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*") -- I don't want to search in the `.git` directory.

			telescope.setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments, -- Overwrite the vimgrep_arguments here.
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
				pickers = {
					find_files = {
						-- `hidden = true` will still show inside of '.git/` as it's not in '.gitignore`
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
			})

			-- Key bindings.
			vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find FILES" })
			vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "Find (GIT) files" })
			vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find BUFFERS" })
			vim.keymap.set("n", "<leader>fM", require("telescope.builtin").oldfiles, { desc = "Find RECENT Files" })
			vim.keymap.set("n", "<leader>fm", require("telescope.builtin").man_pages, { desc = "Find MAN page" })
			vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Find HELP" })
			vim.keymap.set(
				"n",
				"<leader>fw",
				require("telescope.builtin").grep_string,
				{ desc = "Find WORD under cursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>fS",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "Find (S)ymbols" }
			)
			vim.keymap.set("n", "<leader>fs", require("telescope.builtin").live_grep, { desc = "Find (s)TRING" })

			-- LSP pickers
			vim.keymap.set(
				"n",
				"<leader>fc",
				require("telescope.builtin").lsp_references,
				{ desc = "Find reference to string under (c)ursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>fr",
				require("telescope.builtin").lsp_incoming_calls,
				{ desc = "Find (r)eferences incomming calls string under cursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>fo",
				require("telescope.builtin").lsp_outgoing_calls,
				{ desc = "Find references to (o)utgoing calls of string under cursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>rd",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "Find (d)ocument symbols grep" }
			)
			vim.keymap.set(
				"n",
				"<leader>fa",
				require("telescope.builtin").lsp_workspace_symbols,
				{ desc = "Find (a)ll references" }
			)
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>gr",
			-- 	require("telescope.builtin").lsp_references({ desc = "GOTO definition (of word under cursor)" })
			-- )
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>gD",
			-- 	require("telescope.builtin").lsp_declaration,
			-- 	{ desc = "GOTO declaration (of word under cursor)" }
			-- )
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>gi",
			-- 	require("telescope.builtin").lsp_implementation,
			-- 	{ desc = "GOTO implementation (of word under cursor)" }
			-- )
		end,
	},

	-----------PLUGIN: NVIM-TREESITTER------------
	---
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				-- List of parsers to ignore installing (or "all")
				ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- disable = { "c", "rust" },
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	-----------PLUGIN: UNDOTREE------------
	---
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	-----------PLUGIN: VIM-COMMENTARY------------
	---
	{
		"tpope/vim-commentary",
	},

	-----------PLUGIN: VIM-UNIMPARED------------
	---
	{
		"tpope/vim-unimpaired",
	},

	-----------PLUGIN: WHICH-KEY.NVIM------------
	---
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-----------PLUGIN: CLAUDE-CODE.NVIM------------
	---
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		config = function()
			require("claude-code").setup({
				-- Terminal window settings
				window = {
					split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
					position = "botright", -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
					enter_insert = true, -- Whether to enter insert mode when opening Claude Code
					hide_numbers = true, -- Hide line numbers in the terminal window
					hide_signcolumn = true, -- Hide the sign column in the terminal window
				},
				-- File refresh settings
				refresh = {
					enable = true, -- Enable file change detection
					updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
					timer_interval = 1000, -- How often to check for file changes (milliseconds)
					show_notifications = true, -- Show notification when files are reloaded
				},
				-- Git project settings
				git = {
					use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
				},
				-- Shell-specific settings
				shell = {
					separator = "&&", -- Command separator used in shell commands
					pushd_cmd = "pushd", -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
					popd_cmd = "popd", -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
				},
				-- Command settings
				command = "claude", -- Command used to launch Claude Code
				-- Command variants
				command_variants = {
					-- Conversation management
					continue = "--continue", -- Resume the most recent conversation
					resume = "--resume", -- Display an interactive conversation picker

					-- Output options
					verbose = "--verbose", -- Enable verbose logging with full turn-by-turn output
				},
				-- Keymaps
				keymaps = {
					toggle = {
						normal = "<C-,>", -- Normal mode keymap for toggling Claude Code, false to disable
						terminal = "<C-,>", -- Terminal mode keymap for toggling Claude Code, false to disable
						variants = {
							continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
							verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
						},
					},
					window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
					scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
				},
			})
		end,
	},

	-----------PLUGIN: AVANTE.NVIM------------
	---
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		opts = {
			provider = "openai",
			providers = {
				openai = {
					model = "gpt-4o",
					max_tokens = 4000,
				},
				ollama = {
					["local"] = true,
					endpoint = "http://ollama.richardmerry.uk/v1",
					model = "deepseek-coder-v2",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint .. "/chat/completions",
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
							},
							body = {
								model = opts.model,
								messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
								max_tokens = 2048,
								stream = true,
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
			},
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
			},
			hints = { enabled = true },
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},

	-- Debug Adapter Protocol (DAP) plugins
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
}) -- END OF LAZY SETUP

vim.cmd.colorscheme("catppuccin")
