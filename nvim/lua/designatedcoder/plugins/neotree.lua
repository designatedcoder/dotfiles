return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function ()
            require'nvim-web-devicons'.setup {
                strict = true;
                override_by_extension = {
                    ["blade.php"] = {
                        icon="",
                        color="#ff2d20",
                        name = "blade"
                    }
                }
            }
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                window = {
                    width = 30
                },
            })
        end,
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {}),
        vim.keymap.set('n', '<C-t>', ':Neotree filesystem reveal left toggle<CR>', {}),
    }
}
