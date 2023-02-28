local M = {}

M.state = {}

M.execute = function()
  local curr_buf = vim.api.nvim_get_current_buf()
  if not M.state.bufnr or not vim.api.nvim_buf_is_valid(M.state.bufnr) then
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'json')
    vim.api.nvim_command("vsplit | b" .. bufnr)
    M.state.bufnr = bufnr
  end

  local lines = vim.api.nvim_buf_get_lines(curr_buf, 0, -1, false)
  local selected_sql = table.concat(lines, "\n")


  local append_data = function(_, data, _)
    if data then
      vim.api.nvim_buf_set_lines(M.state.bufnr, -1, -1, false, data)
    end
  end
  local jobid = vim.fn.jobstart("dblens exec", {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
  })

  vim.api.nvim_buf_set_lines(M.state.bufnr, 0, -1, false, {})
  vim.fn.chansend(jobid, { selected_sql, "" })
  vim.fn.chanclose(jobid, "stdin")
end

vim.api.nvim_create_user_command('SqlExecute', M.execute, { nargs = 0 })

return M
