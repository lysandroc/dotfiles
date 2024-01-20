return {
    {
        "folke/zen-mode.nvim",
         options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            -- you may turn on/off statusline in zen mode by setting 'laststatus' 
            -- statusline will be shown only if 'laststatus' == 3
            laststatus = 1, -- turn off the statusline in zen mode
        },
        opts = {
            plugins = {
                tmux = { enabled = true }, -- disables the tmux statusline
            },
            on_open = function(win)
                -- hide statusline
                vim.opt.laststatus = 1
            end,
            on_close = function()
                -- show statusline
                vim.opt.laststatus = 3
            end
        },
    }
}
