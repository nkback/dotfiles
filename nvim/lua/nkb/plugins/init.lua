return {
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
        config = function()
        end,
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },
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
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-treesitter/nvim-treesitter' },
    {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
    },
    {
        "tpope/vim-fugitive",
        config = function() 
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

            local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

            local autocmd = vim.api.nvim_create_autocmd
            autocmd("BufWinEnter", {
                group = ThePrimeagen_Fugitive,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = {buffer = bufnr, remap = false}
                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git('push')
                    end, opts)

                    -- rebase always
                    vim.keymap.set("n", "<leader>P", function()
                        vim.cmd.Git({'pull',  '--rebase'})
                    end, opts)

                    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                    -- needed if i did not set the branch up correctly
                    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
                end,
            })


            vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
        end
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
