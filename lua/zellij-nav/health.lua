local M = {}

M.check = function()
  vim.health.report_start("zellij-nav.nvim")
  local version = vim.fn.system("zellij --version")
  if vim.v.shell_error ~= 0 then
    vim.health.report_error("zellij executable not found in user's path")
  else
    vim.health.report_ok("found zellij version " .. string.gsub(version, "zellij ", ""))
  end
end

return M
