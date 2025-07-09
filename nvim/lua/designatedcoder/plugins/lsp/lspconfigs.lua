return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },

        config = function()
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "html",
                    "cssls",
                    "tailwindcss",
                    "lua_ls",
                    "emmet_language_server",
                    "phpactor",
                    "intelephense",
                    "vue_ls",
                    "ts_ls",
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            -- import cmp-nvim-lsp plugin
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local keymap = vim.keymap -- for conciseness

            local opts = { noremap = true, silent = true }

            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.get_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.get_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Change the Diagnostic symbols in the sign column (gutter)
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰠠 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                    texthl = {
                        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                    },
                    numhl = {
                        [vim.diagnostic.severity.WARN] = 'WarningMsg',
                    },
                },

                virtual_text = false, -- Show text after diagnostics
                update_in_insert = false,
                underline = true,
                severity_sort = false,
                float = true,
            })

            -- Show diagnostics text on cursor hold
            local lspGroup = vim.api.nvim_create_augroup("Lsp", { clear = true })

            vim.api.nvim_create_autocmd("CursorHold", {
                command = "lua vim.diagnostic.open_float()",
                group = lspGroup,
            })

            -- Configure LSP servers
            vim.lsp.config("*", {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- configure emmet language server
            vim.lsp.config("emmet_language_server", {
                filetypes = {
                    "php",
                    "vue",
                    "react",
                    "css",
                    "html",
                    "javascript",
                    "less",
                    "sass",
                    "scss",
                    "javascriptreact",
                    "typescriptreact"
                },
            })

            -- configure vue_ls language server
            vim.lsp.config("vue_ls", {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            })

            -- configure ts_ls language server
            vim.lsp.config("ts_ls", {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = 'path_to_typescipt_plugin',
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = {
                    "vue",
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                },
            })

            -- configure lua server (with special settings)
            vim.lsp.config("lua_ls", {
                settings = { -- custom settings for lua
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function ()
            local installer = require("mason-tool-installer")
            installer.setup{
                ensure_installed = {
                    "stylua",
                    "prettierd",
                    "pint",
                    "phpstan",
                },
                run_on_start = true,
                vim.api.nvim_create_autocmd('User', {
                    pattern = "MasonToolsStartingInstall",
                    callback = function ()
                        vim.schedule(function ()
                            print "mason-tool-installer is starting"
                        end)
                    end
                })
            }
        end
    }
}
