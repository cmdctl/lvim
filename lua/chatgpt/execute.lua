local M = {}

M.state = {}

M.execute = function()
  local curr_buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(curr_buf, 0, -1, false)
  local delimiter = "----------------------------------------"

  local append_data = function(_, data, _)
    vim.api.nvim_buf_set_lines(curr_buf, -1, -1, false, data)
  end

  local jobid = vim.fn.jobstart("chatgpt" .. " -d " .. delimiter, {
    stdout_buffered = false,
    on_stdout = append_data,
    on_stderr = append_data,
    on_exit = function()
      vim.api.nvim_buf_set_lines(curr_buf, -1, -1, false, { delimiter })
    end,
  })
  vim.fn.chansend(jobid, lines)
  vim.fn.chanclose(jobid, "stdin")
  vim.api.nvim_buf_set_lines(curr_buf, -1, -1, false, { delimiter })
end

vim.api.nvim_create_user_command('GptRun', M.execute, { nargs = 0 })
vim.api.nvim_create_user_command('GptChat', 'vsplit | enew', { nargs = 0 })

return M
