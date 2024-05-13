return {
  "neovim/nvim-lspconfig",
  -- opts = {
  --   ---@type lspconfig.options
  --   servers = {
  --     csharp_ls = {
  --       handlers = {
  --         ["textDocument/definition"] = function(...)
  --           return require("csharpls_extended").handler(...)
  --         end,
  --         ["textDocument/typeDefinition"] = function(...)
  --           return require("csharpls_extended").handler(...)
  --         end,
  --       },
  --       keys = {
  --         {
  --           "gd",
  --           function()
  --             require("csharpls_extended").lsp_definitions()
  --           end,
  --           desc = "Goto extended Definition",
  --         },
  --       },
  --       organize_imports_on_format = true,
  --       enable_import_completion = true,
  --     },
  --   },
  -- },
  opts = {
    -- Automatically format on save
    autoformat = false,
  },
}
