local lualine = require('lualine')

local M = {}

M.setup = function ()
  lualine.setup {
    options = { theme  = 'gruvbox_light' },
  }
end

return M
