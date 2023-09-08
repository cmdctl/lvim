require("general")
require("keybinds")
require("treesitter")
require("formatters")
require("autocmd.go-test")

require("querio.execute")
require("chatgpt.execute")
require("tengu.lsp")
require("template-string-converter.convert")

lvim.plugins = {
  require("plugins.copilot"),
  { "mfussenegger/nvim-jdtls" },
  { "jparise/vim-graphql" },
  { "nvim-treesitter/playground" },
  require("plugins.rust"),
  { "alx741/vim-rustfmt" },
  require("plugins.autosave"),
  require("plugins.rest")
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
