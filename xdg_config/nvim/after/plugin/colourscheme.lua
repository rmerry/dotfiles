vim.opt.termguicolors = true

if pcall(require, "colorizer") then
  require("colorizer").setup()
end

if not pcall(require, "colorbuddy") then
  return
end

require("colorbuddy").colorscheme("gruvbuddy")
