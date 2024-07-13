local M = {}

local function nav(short_direction, direction, action)
  -- Use "move-focus" if nav is called via user command or
  -- action is nil.
  if type(action) == "table" or not action then
    action = "move-focus"
  end

  if action ~= "move-focus" and action ~= "move-focus-or-tab" then
    error("invalid action: " .. action)
  end

  -- get window ID, try switching windows, and get ID again to see if it worked
  local cur_winnr = vim.fn.winnr()
  vim.api.nvim_command("wincmd " .. short_direction)
  local new_winnr = vim.fn.winnr()

  -- if the window ID didn't change, then we didn't switch
  if cur_winnr == new_winnr then
    vim.fn.system("zellij action " .. action .. " " .. direction)
    if vim.v.shell_error ~= 0 then
      error("zellij executable not found in path")
    end
  end
end

function M.up(action)
  nav("k", "up", action)
end

function M.down(action)
  nav("j", "down", action)
end

function M.right(action)
  nav("l", "right", action)
end

function M.left(action)
  nav("h", "left", action)
end

-- create our exported setup() function
function M.setup(opts)
  -- create our commands
  vim.api.nvim_create_user_command("ZellijNavigateUp", M.up, {})
  vim.api.nvim_create_user_command("ZellijNavigateDown", M.down, {})
  vim.api.nvim_create_user_command("ZellijNavigateLeft", M.left, {})
  vim.api.nvim_create_user_command("ZellijNavigateRight", M.right, {})
end

return M
