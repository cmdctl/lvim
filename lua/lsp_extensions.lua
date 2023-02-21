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
  local filtered_items = {}
  if #items == 2 then
    filtered_items = vim.tbl_filter(filter_item, items)
  end
  if #filtered_items > 0 then
    items = filtered_items
  end
  print("filtered items")
  print(vim.inspect(items))
  vim.fn.setqflist({}, 'r', { title = options.title, items = items, context = options.context })
  if #items == 1 then
    vim.api.nvim_command('cfirst')
  else
    vim.api.nvim_command('copen')
  end
end

function M.go_to_definition_typescript()
  vim.lsp.buf.definition({
    reuse_win = true,
    on_list = on_list,
  })
end

return M
