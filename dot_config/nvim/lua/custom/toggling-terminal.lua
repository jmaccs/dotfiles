local M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function open_float(opts)
  opts = opts or {}

  local ui = vim.api.nvim_list_uis()[1]
  local screen_w = ui.width
  local screen_h = ui.height

  local width = opts.width or math.floor(screen_w * 0.8)
  local height = opts.height or math.floor(screen_h * 0.8)

  local row = math.floor((screen_h - height) / 2)
  local col = math.floor((screen_w - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  return { buf = buf, win = win }
end

-- function M.toggle()
--   if not vim.api.nvim_win_is_valid(state.floating.win) then
--     state.floating = open_float { buf = state.floating.buf }
--     if vim.bo[state.floating.buf].buftype ~= 'terminal' then
--       vim.cmd.terminal()
--     end
--   else
--     vim.api.nvim_win_hide(state.floating.win)
--   end
-- end

function M.toggle(cmd)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_float { buf = state.floating.buf }

    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      if cmd and cmd ~= '' then
        vim.cmd.terminal(cmd)
        state.floating.cmd = cmd
      else
        vim.cmd.terminal()
        state.floating.cmd = nil
      end
    elseif cmd and cmd ~= '' and cmd ~= state.floating.cmd then
      vim.api.nvim_buf_set_lines(state.floating.buf, 0, -1, false, {})
      vim.cmd.terminal(cmd)
      state.floating.cmd = cmd
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
function M.setup(opts)
  opts = opts or {}
  local cmd_name = opts.command or 'TogglingTerminal'

  vim.api.nvim_create_user_command(cmd_name, function(input)
    M.toggle(input.args)
  end, {
    nargs = '?',
    complete = 'shellcmd',
  })
end
-- function M.setup(opts)
--   opts = opts or {}
--   local cmd_name = opts.command or 'TogglingTerminal'
--   vim.api.nvim_create_user_command(cmd_name, M.toggle, {})
-- end
--
return M
