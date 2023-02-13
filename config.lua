require("general")
require("keybinds")
require("treesitter")
require("formatters")


lvim.plugins = {
    require("plugins.copilot"),
    { "jparise/vim-graphql" },
    { "David-Kunz/jester" },
    { "nvim-treesitter/playground" },
    require("plugins.rust"),
    require("plugins.autosave"),
    require("plugins.rest")
}
