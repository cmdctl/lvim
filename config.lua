require("general")
require("keybinds")
require("treesitter")
require("formatters")

require("autoruns.rustfmt")


lvim.plugins = {
  require("plugins.copilot"),
  { "jparise/vim-graphql" },
  { "David-Kunz/jester" },
  { "nvim-treesitter/playground" },
  require("plugins.rust"),
  { "alx741/vim-rustfmt" },
  require("plugins.autosave"),
  require("plugins.rest")
}
