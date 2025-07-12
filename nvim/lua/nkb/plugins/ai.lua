return {
    {
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        adapter = "anthropic",
                    },
                    inline = {
                        adapter = "anthropic",
                    },
                }
            })
        end
    },
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<Tab>",
                    clear_suggestion = "<C-]>",
                    accept_word = "<C-j>",
                },
                ignore_filetypes = {},
                log_level = "info",
                disable_inline_completion = false,
                disable_keymaps = false,
            })
        end,
    },

}
