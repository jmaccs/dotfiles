return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
                                                                ░░██
                                                        ░░██████
                                                          ░░██
  ░░██░░████        ░░████      ░░████    ░░██  ░░██    ░░██      ░░██░░████░░████
░░██████░░████  ░░████████    ░░██░░████░░██████░░████░░████████░░██████░░████░░████
  ░░████░░████  ░░████░░████░░████░░████  ░░████░░████  ░░████    ░░████░░████░░████
  ░░████░░████  ░░██████    ░░████░░████  ░░████░░████  ░░████    ░░████░░████░░████
  ░░████░░████  ░░████      ░░████░░████  ░░████░░████  ░░████    ░░████░░████░░████
░░██████░░██████░░████      ░░████░░██    ░░████████    ░░████  ░░██████░░████░░██████
    ░░██  ░░██    ░░████      ░░████          ░░██        ░░██      ░░██  ░░██  ░░██
      ]],
      },
      sections = {
        { section = 'header' },
        { section = 'keys', indent = 1, gap = 1, padding = 1 },
        {
          section = 'recent_files',
          icon = ' ',
          title = 'Recent Files',
          cwd = true,
          indent = 3,
          padding = 2,
        },
        { section = 'startup' },
        -- { pane = 2, padding = 2 },
        {
          pane = 2,
          section = 'terminal',
          -- cmd = 'ascii-image-converter ~/.config/nvim/img/jupiter.png -C -b --dither; sleep .1',
          cmd = [[set phase (sed 's/.*\(.\)$/\1/' ~/.cache/weather_simple.txt); ascii-image-converter ~/.config/nvim/img/moon/$phase.jpg -C -b --dither]],
          random = 10,
          indent = 4,
          height = 30,
        },
      },
      styles = {
        notification = {
          wo = { winblend = 5, wrap = true },
        },
        notification_history = {
          border = true,
          zindex = 100,
          width = 0.6,
          height = 0.6,
          minimal = false,
          title = ' Notification History ',
          title_pos = 'center',
          ft = 'markdown',
          bo = { filetype = 'snacks_notif_history', modifiable = false },
          wo = { winhighlight = 'Normal:SnacksNotifierHistory', winblend = 20 },
          keys = { q = 'close' },
        },
      },
    },
    image = { enabled = true },
    indent = { enabled = true },
    -- input = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    notify = { enabled = true },
    explorer = { enabled = true },
    -- git = { enabled = true },
    quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    scratch = { enabled = true },
    -- statuscolumn = { enabled = true },
    terminal = { enabled = false },
    -- toggle = { enabled = true },
    -- words = { enabled = true },
  },
}
