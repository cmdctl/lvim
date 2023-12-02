require("general")
require("keybinds")
require("treesitter")
require("formatters")
require("autocmd.go-test")

require("querio.execute")
require("chatgpt.execute")
require("template-string-converter.convert")
require("run-java-test.java-test")
require("transforms.json-to-ts")
require("transforms.json-to-java")
require("transforms.json-to-go")
require("transforms.json-to-zod")
require("devops.open-ticket")

lvim.plugins = {
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { 'kristijanhusak/vim-dadbod-completion' },
  require("plugins.copilot"),
  { "mfussenegger/nvim-jdtls" },
  { "jparise/vim-graphql" },
  { "nvim-treesitter/playground" },
  require("plugins.rust"),
  { "alx741/vim-rustfmt" },
  { "tpope/vim-dotenv" },
  require("plugins.autosave"),
  require("plugins.rest")
}

