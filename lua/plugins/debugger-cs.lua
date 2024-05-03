local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_set = require("telescope.actions.set")

_G.selected_project_root = nil

local function ls_dir(dir)
  local files_and_dirs = vim.fn.globpath(dir, "*", true, true)
  return files_and_dirs
end

function _G.search_dirs()
  local src_path = vim.fn.getcwd() .. "\\src\\"
  -- local pattern = "\\w+\\.Host$"
  local pattern = "Program.cs"
  local cmd = string.format("fd %s %s", pattern, src_path)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    print("Error running fd: " .. output)
    return
  end

  local dirs = vim.split(output, "\n")
  dirs = vim.tbl_filter(function(value)
    return value ~= ""
  end, dirs)

  if #dirs == 0 then
    print("No directories found.")
    return
  end

  if #dirs == 1 then
    _G.selected_project_root = dirs[1]
    return
  end

  pickers
    .new({}, {
      prompt_title = "Select Directory",
      finder = finders.new_table({
        results = dirs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        action_set.select:replace(function()
          local selection = require("telescope.actions.state").get_selected_entry()
          require("telescope.actions").close(prompt_bufnr)
          _G.selected_project_root = selection.value
        end)
        return true
      end,
    })
    :find()
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  optional = true,
  opts = function()
    local dap = require("dap")
    if not dap.adapters["netcoredbg"] then
      require("dap").adapters["netcoredbg"] = {
        type = "executable",
        command = "C:\\Users\\vkarpil\\AppData\\Local\\nvim-data\\netcoredbg\\netcoredbg\\netcoredbg.exe",
        args = { "--interpreter=vscode" },
        options = {
          cwd = _G.selected_project_root,
          detached = false,
        },
      }
    end
    for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
      if not dap.configurations[lang] then
        dap.configurations[lang] = {
          {
            type = "netcoredbg",
            name = "Nice launch",
            request = "launch",
            program = function()
              if _G.selected_project_root then
                local dotnet_dir = _G.selected_project_root .. "bin\\Debug\\"
                local files = ls_dir(dotnet_dir)
                if #files == 1 then
                  local dotnet_dir = files[1]
                  local target_assembly = dotnet_dir .. "\\" .. _G.selected_project_root:match("([^\\]+)\\?$") .. ".dll"
                  return target_assembly
                end

                print("No dll found in " .. dotnet_dir)
                return ""
              else
                _G.search_dirs()
                return ""
              end
            end,
            cwd = _G.selected_project_root,
          },
        }
      end
    end
  end,
}
