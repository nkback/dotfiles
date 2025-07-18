return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    php = { "pint" },
                    -- php = { "php_cs_fixer" },
                },
            })
        end,
    }
}
