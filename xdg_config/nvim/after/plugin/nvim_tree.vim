nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>

let g:nvim_tree_follow=1
let g:nvim_tree_width=30
let g:nvim_tree_highlight_opened_files=3

lua <<EOF

local g = vim.g

function _G.inc_width_ind()
    g.nvim_tree_width = g.nvim_tree_width + 10
    return g.nvim_tree_width
end

function _G.dec_width_ind()
    g.nvim_tree_width = g.nvim_tree_width - 10
    return g.nvim_tree_width
end

local tree_cb = require "nvim-tree.config".nvim_tree_callback

local list = {
  {key = {"0"}, cb = "<CMD>exec ':NvimTreeResize ' . v:lua.inc_width_ind()<CR>"},
  { key = { "<leader>v"},     cb = tree_cb("vsplit"), mode = "n" },
  { key = { "<leader><Tab>"}, cb = tree_cb("tabnew"), mode = "n" }
}

local tree_cb = require "nvim-tree.config".nvim_tree_callback

local list = {
  { key = { "<leader>v"},     cb = tree_cb("vsplit"), mode = "n" },
  { key = { "<leader><Tab>"}, cb = tree_cb("tabnew"), mode = "n" }
}

require'nvim-tree'.setup {
  disable_netrw       = false,
  hijack_netrw        = false,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}

EOF
