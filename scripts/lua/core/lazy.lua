local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    dev = {
        -- directory where you store your local plugin projects
        path = "~/projects",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
    },
    -- plugins are versioned, to know more read setup.sh
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    spec = { {
        import = "plugins",
    } },
    -- spec = {{
    --     "LazyVim/LazyVim",
    --     import = "lazyvim.plugins"
    -- }, {
    --     import = "lazyvim.plugins.extras.lsp.none-ls"
    -- }, {
    --     import = "lazyvim.plugins.extras.lang.typescript"
    -- }, {
    --     import = "lazyvim.plugins.extras.lang.json"
    -- }, {
    --     import = "lazyvim.plugins.extras.lang.rust"
    -- }, {
    --     import = "lazyvim.plugins.extras.ui.mini-animate"
    -- }, -- import/override with your plugins
    -- {
    --     import = "plugins"
    -- }},
    install = {
        -- colorscheme = { "solarized-osaka" },
    },
    change_detection = { notify = false, enable = false },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip", -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
