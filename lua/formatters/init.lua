local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
    require("formatters.rust"),
    require("formatters.typescript")
})
