-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- save file
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- run jest test under curosor
lvim.keys.normal_mode["<C-t>"] = ':lua require"jester".run({path_to_jest_run="npx jest"})<cr>'


-- move between buffers
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["gtl"] = ":GoTestLineDiag<CR>"
lvim.builtin.which_key.mappings["r"] = {
  name = "+run",
  h = { "<cmd>lua require('rest-nvim').run()<CR>", "HTTP request under cursor" }
}

-- lsp mappings
local extentions = require('lsp_extensions')

require('lspconfig')['tsserver'].setup({
  on_attach = function()
    lvim.lsp.buffer_mappings.normal_mode["gd"] = { extentions.go_to_definition_typescript, "Go to definition" }
  end
})
