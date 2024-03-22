return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettierd,
                    --                    null_ls.builtins.formatting.blade_formatter,
                    --                    null_ls.builtins.formatting.rustywind,
                    null_ls.builtins.diagnostics.phpstan,
                    null_ls.builtins.formatting.pint,
                },
            })

            vim.keymap.set("n", "<Leader>gf", vim.lsp.buf.format, {})
        end,
    }
}
