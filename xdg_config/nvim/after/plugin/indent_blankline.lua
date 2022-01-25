if not pcall(require, "indent_blankline") then
  return
end

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#333333 gui=nocombine]]

require("indent_blankline").setup {
    char_highlight_list = { "IndentBlanklineIndent1" },
    space_char_highlight_list = { "IndentBlanklineIndent1" },
}
