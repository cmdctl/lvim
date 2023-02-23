local groupname = "gotest_autorun"
local ns = vim.api.nvim_create_namespace("gotest")

local watch_tests = function(bufnr)
  return function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local parent_dir = vim.fn.fnamemodify(filepath, ":h")
    local append_data = function(_, data, _)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      end
    end
    -- clear the buffer before running tests again
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Running tests... in " .. parent_dir })
    vim.fn.jobstart("go test -v " .. parent_dir .. "/... -json", {
      stdout_buffered = true,
      on_stdout = append_data,
      on_stderr = append_data,
    })
  end
end

local attach_to_buf = function(bufnr)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup(groupname, { clear = true }),
    pattern = "*_test.go",
    callback = watch_tests(bufnr),
  })
end

vim.api.nvim_create_user_command("WatchGoTests", function()
  local bufnr = vim.api.nvim_get_current_buf()
  attach_to_buf(bufnr)
end, {})

vim.api.nvim_create_user_command("WatchGoTestsStop", function()
  vim.api.nvim_create_augroup(groupname, { clear = true })
end, {})

local make_key = function(entry)
  assert(entry.Package, "Must have package: " .. vim.inspect(entry))
  assert(entry.Test, "Must have test: " .. vim.inspect(entry))
  return string.format("%s/%s", entry.Package, entry.Test)
end

local find_test_line = function(bufnr, test_name)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    if line:find(test_name) then
      return i - 1
    end
  end
end

local add_golang_test = function(state, entry)
  if not state.tests then
    state.tests = {}
  end
  local key = make_key(entry)
  state.tests[key] = {
    name = entry.Test,
    line = find_test_line(state.bufnr, entry.Test),
    output = {},
  }
end

local add_golang_output = function(state, entry)
  assert(state.tests, vim.inspect(state))
  table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local mark_success = function(state, entry)
  assert(state.tests, vim.inspect(state))
  state.tests[make_key(entry)].success = entry.Action == "pass"
end


local go_tests_diagnostics = function()
  print(ns)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local state = {
    bufnr = bufnr,
    tests = {},
  }

  local filepath = vim.api.nvim_buf_get_name(0)
  local parent_dir = vim.fn.fnamemodify(filepath, ":h")
  local append_data = function(_, data, _)
    if not data then
      return
    end
    for _, line in ipairs(data) do
      if line ~= "" then
        local decoded = vim.fn.json_decode(line)
        if not decoded then
          return
        end
        if decoded.Action == "run" then
          add_golang_test(state, decoded)
        elseif decoded.Action == "output" then
          if not decoded.Test then
            return
          end
          add_golang_output(state, decoded)
        elseif decoded.Action == "pass" or decoded.Action == "fail" then
          mark_success(state, decoded)
          local test = state.tests[make_key(decoded)]
          if test.success then
            local text = { "✅" }
            vim.api.nvim_buf_set_extmark(state.bufnr, ns, test.line, 0, {
              virt_text = { text },
            })
          end
        elseif decoded.Action == "pause" or decoded.Action == "cont" then
          -- ignore
        else -- unknown
          print("Unknown action: " .. vim.inspect(decoded))
        end
      end
    end
  end
  vim.fn.jobstart("go test -v " .. parent_dir .. "/... -json", {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data,
    on_exit = function()
      local failed = {}
      for _, test in pairs(state.tests) do
        if test.line then
          if not test.success then
            table.insert(failed, {
              bufnr = state.bufnr,
              lnum = test.line,
              col = 0,
              severity = vim.diagnostic.severity.ERROR,
              source = "go-test",
              code = "ERROR",
              message = table.concat(test.output, " "),
              user_data = {}
            })
          end
        end
      end
      vim.diagnostic.set(ns, bufnr, failed, {})
    end
  })
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup(groupname, { clear = true }),
  pattern = "*_test.go",
  callback = go_tests_diagnostics,
})
