return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		provider = "openai",
		openai = {
			model = "gpt-4o",
			max_tokens = 4000,
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
		},
		hints = { enabled = true },
		vendors = {
			---@type AvanteSupportedProvider
			-- ollama = {
			-- 	["local"] = true,
			-- 	endpoint = "http://ollama.richardmerry.uk",
			-- 	model = "codellama",
			-- 	parse_curl_args = function(opts, code_opts)
			-- 		return {
			-- 			url = opts.endpoint .. "/api/generate",
			-- 			headers = {
			-- 				["Accept"] = "application/json",
			-- 				["Content-Type"] = "application/json",
			-- 			},
			-- 			body = {
			-- 				model = opts.model,
			-- 				messages = { -- you can make your own message, but this is very advanced
			-- 					{ role = "system", content = code_opts.system_prompt },
			-- 					{
			-- 						role = "user",
			-- 						content = require("avante.providers.openai").get_user_message(code_opts),
			-- 					},
			-- 				},
			-- 				max_tokens = 2048,
			-- 				stream = true,
			-- 			},
			-- 		}
			-- 	end,
			-- 	parse_response_data = function(data_stream, event_state, opts)
			-- 		require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			-- 	end,
			-- },

			---@type AvanteProvider
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
}
