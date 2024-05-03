return {
  "hrsh7th/nvim-cmp",
  keys = {
    -- disable the keymap to grep files
    {
      "<Tab>",
      function()
        require("cmp").mapping.confirm({ select = true })
      end,
      desc = "Use suggestion",
    },
    -- change a keymap
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
}
