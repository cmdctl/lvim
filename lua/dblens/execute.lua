vim.api.nvim_create_user_command('SqlExecute', function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'json')

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local selected_sql = table.concat(lines, "\n")

  vim.api.nvim_command("vsplit | b" .. bufnr)

  local append_data = function(_, data, _)
    if data then
      vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
    end
  end
  local jobid = vim.fn.jobstart("dblens exec", {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
  })

  vim.fn.chansend(jobid, { selected_sql, "" })
  vim.fn.chanclose(jobid, "stdin")
end, { nargs = 0 })
