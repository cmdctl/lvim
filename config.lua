require("general")
require("keybinds")
require("treesitter")
require("formatters")
require("autocmd.go-test")

require("dblens.execute")

lvim.plugins = {
  require("plugins.copilot"),
  { "jparise/vim-graphql" },
  { "nvim-treesitter/playground" },
  require("plugins.rust"),
  { "alx741/vim-rustfmt" },
  require("plugins.autosave"),
  require("plugins.rest")
}
