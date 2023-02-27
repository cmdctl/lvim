local M = {}

M.groupname = "jest-tests"


M.debaunce = function(fn, delay)
  local timer
  return function()
    if timer then
      -- If the timer is already running, stop it
      timer:stop()
    end
    -- Start a new timer to execute the function after 'delay' milliseconds
    timer = vim.loop.new_timer()
    timer:start(delay, 0, vim.schedule_wrap(function()
      fn()
      timer:stop()
      timer = nil
    end))
  end
end

M.watch_tests = function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(bufnr, "swapfile", false)
  vim.api.nvim_command("vsplit | b" .. bufnr)
  return function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local append_data = function(_, data, _)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      end
    end
    print(vim.api.nvim_buf_is_valid(bufnr))
    if vim.api.nvim_buf_is_valid(bufnr) == false then
      print("old bufnr ", bufnr, " is not valid, creating new one")
      bufnr = vim.api.nvim_create_buf(false, true)
      print("new bufnr ", bufnr)
      vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
      vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
      vim.api.nvim_buf_set_option(bufnr, "swapfile", false)
      vim.api.nvim_command("vsplit | b" .. bufnr)
    end
    -- clear the buffer before running tests again
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Running tests... ", filepath })
    vim.fn.jobstart("npm test -- " .. filepath, {
      stdout_buffered = true,
      on_stdout = append_data,
      on_stderr = append_data,
    })
  end
end
return M
