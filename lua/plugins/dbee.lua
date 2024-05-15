local DBEE_CONNECTIONS = "[{"
  .. '"name": "int-Core",'
  .. '"url": "postgres://{{ env "SECRET_DB_USER" }}:{{ env `SECRET_DB_PASS` }}@localhost:5432/{{ env `SECRET_DB_NAME` }}?sslmode=disable",'
  .. '"type": "postgres"'
  .. "} ]"

return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup(--[[optional config]])
  end,
}
