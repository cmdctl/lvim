require("general")
require("keybinds")
require("treesitter")
require("treesitter-templ")
require("formatters")
require("autocmd.go-test")

require("chatgpt.execute")
require("httpx.execute")
require("template-string-converter.convert")
require("run-java-test.java-test")
require("transforms.json-to-ts")
require("transforms.json-to-java")
require("transforms.json-to-python")
require("transforms.json-to-go")
require("transforms.json-to-zod")
require("transforms.json-to-yaml")
require("transforms.yaml-to-json")
require("devops.open-ticket")

lvim.plugins = {
  {"udalov/kotlin-vim"},
  { "joerdav/templ.vim" },
  { "kylechui/nvim-surround" },
  { "mattn/emmet-vim" },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { 'kristijanhusak/vim-dadbod-completion' },
  { "mfussenegger/nvim-jdtls" },
  { "jparise/vim-graphql" },
  { "nvim-treesitter/playground" },
  { "alx741/vim-rustfmt" },
  { "tpope/vim-dotenv" },
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {"leoluz/nvim-dap-go"},
  require("plugins.rust"),
  require("plugins.copilot"),
  require("plugins.autosave"),
  {"BlackLight/nvim-http"}
}


require("nvim-surround").setup()
require("dap-go").setup()
