if not pcall(require, "lspconfig") then
  return
end

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  if pcall(require, "lsp-status") then
    local nvim_status = require "lsp-status"
    nvim_status.on_attach(client)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if pcall(require, "telescope") then
    buf_set_keymap('n', '<space>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
    buf_set_keymap('n', '<space>wd', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
    buf_set_keymap('n', '<space>ww', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
    buf_set_keymap('n', 'gI', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
    buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
    buf_set_keymap('n', "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  else

  end
end

-- Build the capabilities object.
local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "lsp-status") then
  local nvim_status = require "lsp-status"
  updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
end
if pcall(require, "cmp_nvim_lsp") then
  updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  sumneko_lua = {
    cmd = { "lua-language-server" },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
  },
  gopls = {},
  rust_analyzer = {
    cmd = { "rls" },
  },
  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
}

-- Loop through the list of servers and register their configs.
for server, config in pairs(servers) do
  config = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config)

  nvim_lsp[server].setup(config)
end

