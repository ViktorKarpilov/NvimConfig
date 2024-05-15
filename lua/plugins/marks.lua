return {
  "chentoast/marks.nvim",
  event = "FileType",
  opts = {
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    bookmark_1 = { sign = "󰈼" }, -- ⚐ ⚑ 󰈻 󰈼 󰈽 󰈾 󰈿 󰉀 ⚒
    bookmark_2 = { sign = "󰈿" }, -- ⚐ ⚑ 󰈻 󰈼 󰈽 󰈾 󰈿 󰉀 ⚒
    mappings = {
      annotate = "m<Space>",
    },
    builtin_marks = { ".", "<", ">", "^" },
  },
}
