-- Define a function to start the LSP server for text files
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local lspconfig = require('lspconfig')

local function start_text_lsp()
  vim.cmd("autocmd FileType text setlocal omnifunc=v:lua.vim.lsp.omnifunc")
  -- vim.cmd("au BufRead,BufNewFile,BufEnter *.tsql setfiletype sql")
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  -- Configure the LSP server for text files
  lspconfig.sqls.setup({
    cmd = { "node",
      "/Users/antonbozhinov/dev/github.com/cmdctl/typescript/dblsp/server/out/main.js",
      "lsp", "--stdio" },
    filetypes = { "sql" },
    single_file_support = true,
    capabilities = capabilities,
    log_level = vim.log.levels.DEBUG
  })
  vim.lsp.set_log_level 'info'
end

-- Call the function to start the LSP server for text files
start_text_lsp()
