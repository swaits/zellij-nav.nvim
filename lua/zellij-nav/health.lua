local M = {}


M._check = function()
    vim.health.start("zellij-nav.nvim")
    local version = vim.fn.system("zellij --version")
    if vim.v.shell_error ~= 0 then
        vim.health.error("zellij executable not found in user's path")
    else
        vim.health.ok("found zellij version " .. string.gsub(version, "zellij ", ""))
    end
end

M.deprecated_check = function()
    vim.health.report_start("zellij-nav.nvim")
    local version = vim.fn.system("zellij --version")
    if vim.v.shell_error ~= 0 then
        vim.health.report_error("zellij executable not found in user's path")
    else
        vim.health.report_ok("found zellij version " .. string.gsub(version, "zellij ", ""))
    end
end

M.check = function()
    local vim_version = vim.version()
    if vim_version.minor > 10 then
        M._check()
    else
        M.deprecated_check()
    end
end

return M
