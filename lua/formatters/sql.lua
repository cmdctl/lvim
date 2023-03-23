-- https://www.npmjs.com/package/sql-formatter
local home_dir = os.getenv("HOME")
return {
  command = "sql-formatter",
  filetypes = { "sql" },
  args = { "-c", home_dir .. "/.config/lvim/lua/formatters/sql-formatter.json" },
}
