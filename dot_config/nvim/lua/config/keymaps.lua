vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

local ss = require 'smart-splits'
-- Resize splits
vim.keymap.set('n', '<A-h>', ss.resize_left, { desc = 'Resize split left' })
vim.keymap.set('n', '<A-j>', ss.resize_down, { desc = 'Resize split down' })
vim.keymap.set('n', '<A-k>', ss.resize_up, { desc = 'Resize split up' })
vim.keymap.set('n', '<A-l>', ss.resize_right, { desc = 'Resize split right' })

-- Move between splits
vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = 'Move to split below' })
vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = 'Move to split above' })
vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = 'Move to right split' })
vim.keymap.set('n', '<C-\\>', ss.move_cursor_previous, { desc = 'Move to previous split' })

-- Swap buffers
vim.keymap.set('n', '<leader><leader>h', ss.swap_buf_left, { desc = 'Swap buffer left' })
vim.keymap.set('n', '<leader><leader>j', ss.swap_buf_down, { desc = 'Swap buffer down' })
vim.keymap.set('n', '<leader><leader>k', ss.swap_buf_up, { desc = 'Swap buffer up' })
vim.keymap.set('n', '<leader><leader>l', ss.swap_buf_right, { desc = 'Swap buffer right' })

-- Quick write buf
vim.keymap.set('n', '<leader>w', ': w <CR>', { desc = 'Write current buffer' })

vim.keymap.set('n', '<leader>ee', function()
  Snacks.explorer {
    layout = { position = 'top-left' },
  }
end, { desc = '[E]xplor[e]r (CWD)' })

vim.keymap.set('n', '<leader>ec', function()
  Snacks.explorer {
    cwd = vim.fn.expand '%:p:h',
    layout = { position = 'top-left' },
  }
end, { desc = '[E]xplorer ([C]urrent file dir)' })

-- unset s for flash
-- vim.keymap.unset("n", "s")
-- zig
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.zig', '*.zon' },
  callback = function()
    for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      if client.supports_method 'textDocument/codeAction' then
        vim.lsp.buf.code_action {
          apply = true,
          context = {
            only = {
              'source.fixAll',
              'source.organizeImports',
            },
          },
        }
        return
      end
    end
  end,
})
local wk = require 'which-key'
local Snacks = require 'snacks'

wk.add {
  -- top lvl groups
  { '<leader>l', group = '[L]azy' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>c', group = '[C]ode' },
  { '<leader>g', group = '[G]oto' },
  { '<leader>d', group = '[D]ebug' },
  { '<leader>t', group = '[T]erminal' },
  { '<leader>o', group = '[O]pen' },
  { '<leader>e', group = '[E]xplorer' },
  { '<leader>b', group = '[B]uild' },
  { '<leader>dt', group = '[D]ebug [T]rouble' },
  { '<leader>9', group = 'AI this, ai that' },

  -- compiler

  { '<leader>bc', '<cmd>CompilerOpen<CR>', desc = '[B]uild run Compiler', noremap = true, silent = true },
  { '<leader>bb', '<cmd>CompilerStop<CR> <CMD>CompilerRedo<CR>', desc = '[B]uild redo last', noremap = true, silent = true },
  { '<leader>bt', '<cmd>CompilerToggleResults<CR>', desc = '[B]uild [T]oggle', noremap = true, silent = true },

  { '<leader>bl', group = 'LÖVE' },
  { '<leader>blr', '<cmd>LoveRun<cr>', desc = '[L]ÖVE [R]un' },
  { '<leader>bls', '<cmd>LoveStop<cr>', desc = '[L]ÖVE [S]top' },
  -- Toggleterm

  {
    '<leader>tt',
    '<C-\\><C-n>:TogglingTerminal<CR>',
    desc = '[t]oggle [t]erminal',
    mode = { 'n', 't' },
  },
  {
    '<leader>tw',
    '<C-\\><C-n>:TogglingTerminal weathr<CR>',
    desc = '[t]oggle [w]eather',
    mode = { 'n', 't' },
  },
  -- Code format
  {
    '<leader>cf',
    function()
      require('conform').format { async = true, lsp_fallback = true }
    end,
    desc = '[C]ode [F]ormat',
  },
  -- [D]ebug group

  {
    '<leader>db',
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = '[D]ebug [B]reakpoint',
  },
  {
    '<leader>dc',
    function()
      require('dap').continue()
    end,
    desc = '[D]ebug [C]ontinue',
  },
  {
    '<leader>di',
    function()
      require('dap').step_into()
    end,
    desc = '[D]ebug step [I]nto',
  },
  {
    '<leader>do',
    function()
      require('dap').step_over()
    end,
    desc = '[D]ebug step [O]ver',
  },
  {
    '<leader>dO',
    function()
      require('dap').step_out()
    end,
    desc = '[D]ebug step [O]ut',
  },
  {
    '<leader>dr',
    function()
      require('dap').repl.open()
    end,
    desc = '[D]ebug [R]EPL',
  },
  {
    '<leader>dl',
    function()
      require('dap').run_last()
    end,
    desc = '[D]ebug run [L]ast',
  },
  {
    '<leader>de',
    function()
      require('dap').terminate()
    end,
    desc = '[D]ebug t[E]rminate',
  },
  {
    '<leader>du',
    function()
      require('dapui').toggle()
    end,
    desc = '[D]ebug [U]I toggle',
  },

  {
    '<leader>lg',
    function()
      Snacks.lazygit()
    end,
    desc = '[L]azy[G]it',
  },
  {
    '<leader>ln',
    function()
      Snacks.notifier.show_history()
    end,
    desc = '[L]azy[N]otifications',
  },

  {
    ']]',
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = 'Next Reference',
    mode = { 'n', 't' },
  },
  {
    '[[',
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = 'Prev Reference',
    mode = { 'n', 't' },
  },

  -- snacks key maps

  {
    '<leader>ss',
    function()
      Snacks.picker.smart()
    end,
    desc = 'Smart Find Files',
  },
  {
    '<leader><space>',
    function()
      Snacks.picker.buffers()
    end,
    desc = '[ ] Find existing buffers',
  },
  {
    '<leader>sG',
    function()
      Snacks.picker.grep { cwd = vim.fn.getcwd() }
    end,
    desc = '[S]earch by [g]rep (CWD)',
  },
  {
    '<leader>sg',
    function()
      Snacks.picker.grep { cwd = vim.fn.expand '%:p:h' }
    end,
    desc = '[S]earch by [G]rep (buffer directory)',
  },
  {
    '<leader>sn',
    function()
      Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
    end,
    desc = '[S]earch [N]eovim files',
  },
  {
    '<leader>sf',
    function()
      Snacks.picker.files()
    end,
    desc = '[S]earch [F]iles',
  },
  {
    '<leader>sp',
    function()
      Snacks.picker.pickers()
    end,
    desc = '[S]earch [P]ickers',
  },
  {
    '<leader>s.',
    function()
      Snacks.picker.recent()
    end,
    desc = "[S]earch Recent Files ('.' for repeat)",
  },
  {
    '<leader>sk',
    function()
      Snacks.picker.keymaps()
    end,
    desc = '[S]earch [K]eymaps',
  },
  {
    '<leader>sw',
    function()
      Snacks.picker.grep_word()
    end,
    desc = '[S]earch current [W]ord',
    mode = { 'n', 'x' },
  },
  {
    '<leader>sr',
    function()
      Snacks.picker.resume()
    end,
    desc = '[S]earch [R]esume',
  },
  {
    '<leader>sh',
    function()
      Snacks.picker.help()
    end,
    desc = '[S]earch [H]elp',
  },
  {
    '<leader>sd',
    function()
      Snacks.picker.diagnostics()
    end,
    desc = '[S]earch [D]iagnostics',
  },
  {
    '<leader>sD',
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = 'Buffer Diagnostics',
  },
  {
    '<leader>s/',
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = '[S]earch [/] in Open Files',
  },
  {
    '<leader>/',
    function()
      Snacks.picker.lines {
        -- use the Select layout
        layout = {
          preset = 'select', -- ⟵ preset defined in docs :contentReference[oaicite:0]{index=0}
        },
      }
    end,
    desc = '[/] Fuzzily search in current buffer',
  },
}
