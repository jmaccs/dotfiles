vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.expandtab = true

vim.opt.shiftwidth = 4

vim.opt.tabstop = 4

vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.confirm = true

vim.opt.termguicolors = true

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})



vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- function Make_And_Run()
--   -- run make
--   vim.cmd('write')  -- save 
--   local make_result = vim.fn.system('make 2>&1')
  
--   if vim.v.shell_error == 0 then
--     print('Build successful!')
    
--     -- find exe
--     local makefile_content = vim.fn.readfile('Makefile')
--     local target = nil
    
--     for _, line in ipairs(makefile_content) do
--       -- target grep
--       local match = line:match('^([%w_-]+):%s*')
--       if match and match ~= 'clean' and match ~= 'all' and match ~= 'bear' then
--         target = match
--         break
--       end
--     end
    
--     if target then
--       vim.cmd('terminal ./' .. target)
--     else
--       -- fallback to common
--       vim.cmd('terminal ./main')
--     end
--   else
--     print('Build failed!')
--     print(make_result)
--   end
-- end