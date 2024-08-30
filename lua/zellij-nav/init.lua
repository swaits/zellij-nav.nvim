local M = {}

local function nav(short_direction, direction, action)
  -- Use "move-focus" if action is nil.
  if not action then
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

function M.up()
  nav("k", "up", nil)
end

function M.down()
  nav("j", "down", nil)
end

function M.right()
  nav("l", "right", nil)
end

function M.left()
  nav("h", "left", nil)
end

function M.up_tab()
  nav("k", "up", "move-focus-or-tab")
end

function M.down_tab()
  nav("j", "down", "move-focus-or-tab")
end

function M.right_tab()
  nav("l", "right", "move-focus-or-tab")
end

function M.left_tab()
  nav("h", "left", "move-focus-or-tab")
end

-- create our exported setup() function
function M.setup(opts)
  -- create our commands
  vim.api.nvim_create_user_command("ZellijNavigateUp", M.up, {})
  vim.api.nvim_create_user_command("ZellijNavigateDown", M.down, {})
  vim.api.nvim_create_user_command("ZellijNavigateLeft", M.left, {})
  vim.api.nvim_create_user_command("ZellijNavigateRight", M.right, {})

  vim.api.nvim_create_user_command("ZellijNavigateUpTab", M.up_tab, {})
  vim.api.nvim_create_user_command("ZellijNavigateDownTab", M.down_tab, {})
  vim.api.nvim_create_user_command("ZellijNavigateLeftTab", M.left_tab, {})
  vim.api.nvim_create_user_command("ZellijNavigateRightTab", M.right_tab, {})
end

return M
