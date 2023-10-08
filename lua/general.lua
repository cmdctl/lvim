-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.renderer.group_empty = true
lvim.builtin.nvimtree.setup.renderer.add_trailing = true
lvim.builtin.nvimtree.setup.renderer.full_name = true
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
lvim.builtin.breadcrumbs.active = false
lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.lualine.options.theme = {
  normal = {
    c = { bg = nil },
  },
  insert = {
    c = { bg = nil },
  },
  visual = {
    c = { bg = nil },
  },
  replace = {
    c = { bg = nil },
  },
  command = {
    c = { bg = nil },
  },
  inactive = {
    c = { bg = nil },
  },
}


lvim.builtin.dap.ui.config.layouts = {
  {
    elements = {
      { id = "console", size = 1 },
    },
    size = 0.33,
    position = "bottom",
  },
  {
    elements = {
      { id = "repl",        size = 0.25 },
      { id = "scopes",      size = 0.50 },
      { id = "breakpoints", size = 0.25 },
      -- { id = "stacks",      size = 0.25 },
    },
    size = 0.2,
    position = "left",
  },
}

-- remove cursorline
vim.api.nvim_exec([[
  autocmd BufEnter * set nocursorline
]], false)

vim.cmd([[
    augroup FileTypeMine
        autocmd!
        autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
    augroup END
]])

-- Transparent window settings
lvim.transparent_window = true
lvim.autocommands = {
  -- other commands,
  {
    "ColorScheme",
    { command = "hi NvimTreeNormalNC guibg=NONE" }
  },
  {
    "ColorScheme",
    { command = "hi NvimTreeWinSeparator guibg=NONE" }
  }
}

-- quickfix window settings
-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
  })


vim.g.db_ui_execute_on_save = 0
vim.cmd("autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni")

-- :set nofoldenable
vim.cmd("set nofoldenable")
