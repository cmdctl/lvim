local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
  require("formatters.rust"),
  require("formatters.typescript"),
  require("formatters.sql"),
  require("formatters.python"),
})
