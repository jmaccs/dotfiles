vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require 'config.lazy'
require 'config.options'
require 'config.keymaps'

-- Custom plugs
require('custom.toggling-terminal').setup()
