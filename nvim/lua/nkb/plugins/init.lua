return {
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-buffer",
    --     },
    --     config = function()
    --     end,
    -- },
    { 'windwp/nvim-autopairs', config = true },
    { "mistricky/codesnap.nvim", 
        build = "make",
        config = function()
            require("codesnap").setup({
                watermark = "👁",
            })
        end
    },
    { "nvim-tree/nvim-web-devicons",    lazy = true },
    {
        "Wansmer/treesj",
        keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "monaqa/dial.nvim",
        keys = { "<C-a>", { "<C-x>", mode = "n" } },
    },
    {
        "danymat/neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local neogen = require("neogen")

            neogen.setup({
                snippet_engine = "luasnip"
            })

            vim.keymap.set("n", "<leader>nf", function()
                neogen.generate({ type = "func" })
            end)

            vim.keymap.set("n", "<leader>nt", function()
                neogen.generate({ type = "type" })
            end)
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
    }
}
