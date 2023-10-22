require("general")
require("keybinds")
require("treesitter")
require("formatters")
require("autocmd.go-test")

require("querio.execute")
require("chatgpt.execute")
require("template-string-converter.convert")
require("run-java-test.single-test")

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

vim.cmd("autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni")
vim.cmd(
"autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })")

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
