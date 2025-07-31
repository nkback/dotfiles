return {
    {
        -- Git signs in gutter + inline blame
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 500,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                preview_config = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            })

            -- Minimal keymaps - just visualization and navigation
            local gs = package.loaded.gitsigns

            -- Blame features
            vim.keymap.set('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
            vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle inline blame" })
            vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })

            -- Visual mode blame for selected lines
            vim.keymap.set('v', '<leader>hb', function()
                -- Get selected line range
                local start_line = vim.fn.line("'<")
                local end_line = vim.fn.line("'>")

                -- Use Fugitive's Git blame for range (opens in new buffer)
                vim.cmd(string.format('%d,%dGit blame', start_line, end_line))
            end, { desc = "Blame selected lines" })

            -- Preview changes (useful even if you use CLI)
            vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk changes" })
            vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted lines" })

            -- Navigation
            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true, desc = "Next hunk"})

            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true, desc = "Prev hunk"})
        end,
    },
}
