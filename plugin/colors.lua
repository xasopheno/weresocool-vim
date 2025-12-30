-- Auto-load weresocool color highlighting
if vim.g.loaded_weresocool_colors then
  return
end
vim.g.loaded_weresocool_colors = true

require('weresocool.colors').setup()
