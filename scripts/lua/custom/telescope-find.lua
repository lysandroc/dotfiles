-- call via:
-- :lua require("custom.telescope-find").find_files()

local M = {}

M.find_files = function()
  local opts = {}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

return M

