local M = {}


local function matches_node_module_declaration(filename)
  return string.match(filename, "node_modules/.+%.d%.ts$")
end

local function filter_item(item)
  return not matches_node_module_declaration(item.filename)
end

local on_list = function(options)
  local items = options.items
  print("initial items")
  print(vim.inspect(items))
  if items == nil or vim.tbl_isempty(items) then
    return
  end
  if #items == 2 then
    items = vim.tbl_filter(filter_item, items)
  end
  print("filtered items")
  print(vim.inspect(items))
  vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
  vim.api.nvim_command('cfirst')
end

function M.go_to_definition_typescript()
  vim.lsp.buf.definition({
    reuse_win = true,
    on_list = on_list,
  })
end

return M



