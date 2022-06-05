vim.opt.termguicolors = true

if pcall(require, "colorizer") then
  require("colorizer").setup()
end

vim.g.vscode_italic_comment = 1
require('vscode').change_style("dark") 
