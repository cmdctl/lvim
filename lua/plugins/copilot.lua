Plugin =  { "github/copilot.vim" }
-- Copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
  markdown = 1
}

local cmp = require "cmp"

lvim.builtin.cmp.mapping["<M-CR>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end

return Plugin
