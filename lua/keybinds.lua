-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- move between buffers
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- open .env file
lvim.keys.normal_mode["<C-e>"] = ":e .env<CR>"

-- open word under cursor in project search
lvim.keys.normal_mode["<C-s><C-w>"] = ":lua require'telescope.builtin'.grep_string()<CR>"

-- dbui
lvim.keys.normal_mode["<C-b>"] = ":DBUIToggle<CR> :NvimTreeToggle<CR>"

-- source .env file
lvim.keys.normal_mode["<C-s><C-e>"] = ":Dotenv .env<CR>"

lvim.builtin.lir.show_hidden_files = true

vim.cmd("autocmd FileType go nmap gtl :GoTestLineDiag<CR>")
vim.cmd("autocmd FileType dbui nmap <C-s><C-s> <Plug>(DBUI_ExecuteQuery)")

vim.cmd("autocmd FileType javascript,typescript,typescriptreact nmap <C-t> :JestTestsWatch<CR>")
vim.cmd("autocmd FileType javascript,typescript,typescriptreact nmap <C-t>s :JestTestsStop<CR>")

vim.cmd("autocmd FileType javascript,typescript,typescriptreact nmap <C-s>c :ConvertToTemplateString<CR>")

lvim.builtin.which_key.mappings["r"] = {
  name = "+run",
  h = { "<cmd>lua require('rest-nvim').run()<CR>", "HTTP request under cursor" },
  s = { "<cmd>SqlExecute<CR>", "Execute the current SQL file to an active conenction" },
  g = { "<cmd>GptRun<CR>", "Execute the current buffer as a ChatGPT request" },
  c = { "<cmd>GptChat<CR>", "Open new gpt chat buffer" }
}
-- lsp mappings
local extentions = require('lsp_extensions')
local lspconfig = require('lspconfig')

lspconfig['tsserver'].setup({
  on_attach = function()
    lvim.lsp.buffer_mappings.normal_mode["gd"] = { extentions.go_to_definition_typescript, "Go to definition" }
  end
})

lvim.builtin.terminal.execs = {
  { nil, "<A-k>", "Horizontal Terminal", "horizontal", 0.3 },
  { nil, "<A-l>", "Vertical Terminal",   "vertical",   0.4 },
  { nil, "<A-j>", "Float Terminal",      "float",      nil },
}
