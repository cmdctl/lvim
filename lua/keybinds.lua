-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- move between buffers
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

vim.cmd("autocmd FileType go nmap gtl :GoTestLineDiag<CR>")
vim.cmd("autocmd FileType typescript nmap <C-t> :JestTestsWatch<CR>")
vim.cmd("autocmd FileType typescriptreact nmap <C-t> :JestTestsWatch<CR>")
vim.cmd("autocmd FileType typescriptreact nmap <C-t>s :JestTestsStop<CR>")

lvim.builtin.which_key.mappings["r"] = {
  name = "+run",
  h = { "<cmd>lua require('rest-nvim').run()<CR>", "HTTP request under cursor" },
  s ={ "<cmd>SqlExecute<CR>", "Execute the current SQL file to an active conenction" }
}
-- lsp mappings
local extentions = require('lsp_extensions')
local lspconfig = require('lspconfig')

lspconfig['tsserver'].setup({
  on_attach = function()
    lvim.lsp.buffer_mappings.normal_mode["gd"] = { extentions.go_to_definition_typescript, "Go to definition" }
  end
})
