local M = {}

M.check = function()
  local start = vim.health.start
  local report_ok = vim.health.ok
  local report_error = vim.health.error

  start("zellij-nav.nvim")
  local version = vim.fn.system("zellij --version")
  if vim.v.shell_error ~= 0 then
    report_error("zellij executable not found in user's path")
  else
    report_ok("found zellij version " .. string.gsub(version, "zellij ", ""))
  end
end

return M
