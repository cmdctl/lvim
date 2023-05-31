-- Define a function to start the LSP server for text files
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local lspconfig = require('lspconfig')

local function start_sql_lsp()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  -- Configure the LSP server for sql files
  -- TODO: use custom namespace different from 'sqls' as it is used by another lsp
  lspconfig.sqls.setup({
    cmd = { "tengu", "lsp" },
    filetypes = { "sql" },
    single_file_support = true,
    capabilities = capabilities,
  })
  -- set log level
  vim.lsp.set_log_level("info")
end

-- Call the function to start the LSP server for text files
start_sql_lsp()
