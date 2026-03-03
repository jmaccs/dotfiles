---@diagnostic disable-next-line: undefined-global
local vim = vim

require 'config'

function Transparent(color)
  color = color or 'everforest'
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end
Transparent()
