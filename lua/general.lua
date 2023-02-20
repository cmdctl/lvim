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



-- Transparent window settings
lvim.transparent_window = true
lvim.autocommands = {
   -- other commands,
   {
     "ColorScheme",
     { command = "hi NvimTreeNormalNC guibg=NONE" }
   }
}
