return {
     {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = require('telescope.actions').move_selection_previous,
                            ["<C-j>"] = require('telescope.actions').move_selection_next,
                        },
                    },
                },
            })

            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>pr', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>pc', function()
                builtin.grep_string({ search = vim.fn.expand("<cword>") })
            end)
            vim.keymap.set('n', '<leader>pd', function()
                builtin.grep_string({ search = 'function ' .. vim.fn.expand("<cword>") })
            end)
            vim.keymap.set('n', '<leader>pp', function()
                builtin.planets({})
            end)
            vim.keymap.set('n', '<leader>po', builtin.lsp_document_symbols, { desc = "Document symbols/functions" })
            vim.keymap.set('n', '<leader>pwo', builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
        end,
    },
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
                    "intelephense",
                    "gopls",
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
                    ["intelephense"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.intelephense.setup {
                            capabilities = capabilities,
                            settings = {
                                intelephense = {
                                    diagnostics = {
                                        undefinedFunctions = false,
                                        undefinedConstants = false,
                                        undefinedVariables = false,
                                    },
                                    environment = {
                                        includePaths = {
                                            "vendor/laravel/framework/src/Illuminate/Support/helpers.php"
                                        }
                                    },
                                    files = {
                                        associations = {
                                            "*.php",
                                            "*.phtml"
                                        },
                                        exclude = {
                                            "**/node_modules/**",
                                            "**/vendor/**"
                                        }
                                    },
                                    completion = {
                                        insertUseDeclaration = true,
                                        fullyQualifyGlobalConstantsAndFunctions = false,
                                        triggerParameterHints = true,
                                        maxItems = 100,
                                    },
                                    format = {
                                        enable = true,
                                        braces = "allman"
                                    }
                                }
                            }
                        }
                    end,
                    ["gopls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.gopls.setup {
                            capabilities = capabilities,
                            settings = {
                                gopls = {
                                    analyses = {
                                        unusedparams = true,
                                        staticcheck = true,
                                    },
                                    hints = {
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        compositeLiteralTypes = true,
                                        constantValues = true,
                                        functionTypeParameters = true,
                                        parameterNames = true,
                                        rangeVariableTypes = true,
                                    },
                                },
                            },
                        }
                    end,
                    -- ["phpactor"] = function()
                    --     local lspconfig = require("lspconfig")
                    --     lspconfig.phpactor.setup {
                    --         capabilities = capabilities,
                    --         init_options = {
                    --             ["completion_worse_limit"] = 1000,
                    --             ["worse_reflection.enabled"] = true,
                    --             ["language_server_completion.enabled"] = true,
                    --             ["language_server_hover.enabled"] = true,
                    --             ["language_server_references.enabled"] = true,
                    --             ["language_server_definition.enabled"] = true,
                    --             ["language_server_diagnostics.enabled"] = true,
                    --             ["language_server_code_action.enabled"] = true,
                    --         }
                    --     }
                    -- end,
                }
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    --
                    -- vim.keymap.set('n', 'gd', function()
                    --     require('telescope.builtin').lsp_definitions()
                    -- end, opts)
                    vim.keymap.set("n", "<leader>af", function()
                        vim.cmd("normal! vi}=")
                    end, { desc = "LSP format inside brackets" })
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                              -- vim.keymap.set('n', 'gd', function()
                    --     local params = vim.lsp.util.make_position_params()
                    --     vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
                    --         if err or not result or vim.tbl_isempty(result) then
                    --             vim.notify('No definition found', vim.log.levels.WARN)
                    --             return
                    --         end
                    --
                    --         -- If only one result, jump directly
                    --         if #result == 1 then
                    --             vim.lsp.util.show_document(result[1], 'utf-8')
                    --             -- If multiple results but they're all the same file, just jump to first
                    --         elseif #result > 1 then
                    --             local first_uri = result[1].uri or result[1].targetUri
                    --             local all_same_file = true
                    --
                    --             for _, location in ipairs(result) do
                    --                 local uri = location.uri or location.targetUri
                    --                 if uri ~= first_uri then
                    --                     all_same_file = false
                    --                     break
                    --                 end
                    --             end
                    --
                    --             if all_same_file then
                    --                 -- All results are in the same file, just jump to the first one
                    --                 vim.lsp.util.show_document(result[1], 'utf-8')
                    --             else
                    --                 -- Different files, use telescope
                    --                 require('telescope.builtin').lsp_definitions()
                    --             end
                    --         end
                    --     end)
                    -- end, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                end,
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
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
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
}
