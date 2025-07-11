return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "transparent",  -- Changed to transparent
                    floats = "transparent",    -- Changed to transparent
                },
            })
            vim.cmd("colorscheme tokyonight-storm")
        end
    },
}

