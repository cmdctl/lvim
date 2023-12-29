-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')

local on_attach = require("lvim.lsp").common_on_attach
local on_init = require("lvim.lsp").common_on_init

local servers = { 'gopls', 'ccls', 'cmake', 'tsserver', 'templ', 'kotlin_language_server' }
print("LSP: " .. table.concat(servers, ", "))
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    flags = {
      debounce_text_changes = 150,
    },
  }
end
