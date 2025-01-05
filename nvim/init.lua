vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = "  "

vim.opt.guicursor = {
  "n-v-c:block",      -- Normal, Visual, and Command modes: block cursor
  -- "i:block50",          -- Insert mode: vertical bar cursor, 50% width
  -- "r:hor20",          -- Replace mode: horizontal line cursor, 20% height
  -- "o:hor50",          -- Operator-pending mode: horizontal line, 50% height
}

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.cmd.colorscheme "catppuccin-mocha"

vim.schedule(function()
  require "mappings"
end)
