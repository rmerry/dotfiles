local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("go", {
  s("testservice", {
    t({
      "func TestService_GetCards(t *testing.T) {",
      "\ttype tcGiven struct {",
      "",
      "\t}",
      "",
      "\ttype tcExpected struct {",
      "",
      "\t}",
      "",
      "\ttype testCase struct {",
      "\t\tname  string",
      "\t\tgiven tcGiven",
      "\t\texp   tcExpected",
      "\t}",
      "",
      "\ttests := []testCase{",
      "\t\t{",
      "\t\t},",
      "\t}",
      "",
      "\tfor i := range tests {",
      "\t\ttc := tests[i]",
      "",
      "\t\tt.Run(tc.name, func(t *testing.T) {",
      "",
      "\t\t})",
      "\t}",
      "}",
    }),
    i(0),
  }),
})

