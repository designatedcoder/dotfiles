return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "php",
                "html",
                "css",
                "scss",
                "vue",
                "phpdoc",
                "markdown",
                "markdown_inline",
                "php_only",
                "blade",
                "typescript"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
                    node_incremental = "<leader>si",
                    scope_incremental = "<leader>sc",
                    node_decremental = "<leader>sd",
                },
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = true,
                },
            },
        },

        config = function (_, opts)
            -- See tree-sitter-blade discussions for info on how to set this up
            -- https://github.com/EmranMR/tree-sitter-blade/discussions/19#discussioncomment-9800880
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }

            vim.filetype.add({
                pattern = {
                    [".*%.blade%.php"] = "blade",
                },
            })

            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
