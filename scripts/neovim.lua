-- Set preferences, load plugins, and define global keymaps
require("core")
-- Define plugins' customization
require("config")

-- Override print fn
_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd
