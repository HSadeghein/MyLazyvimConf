return
{
    {
        "snacks.nvim",
        opts = {
            scroll = { enabled = false },
        }
    },
    -- {
    --     'saghen/blink.cmp',
    --     opts = {
    --         completion = {
    --             list = {
    --                 selection = 'manual',
    --             },
    --         },
    --         cmdline = {
    --             enabled = true,
    --             keymap = {
    --                 ['<CR>'] = { 'accept' },
    --             },
    --             sources = {
    --                 'path', 'cmdline'
    --             }
    --         }
    --     }
    -- }

    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require('telescope').setup({
                defaults = {
                    sorting_strategy = 'ascending',
                    file_ignore_patterns = { "node_modules", ".git/" },
                },
            })

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
            vim.keymap.set('n', '<leader><leader>', function()
                builtin.oldfiles({
                    only_cwd = true,
                })
            end, {})
        end,
        -- keys = {
        --     -- add a keymap to browse plugin files
        --     -- stylua: ignore
        --     {
        --         "<leader>fs",
        --         function()
        --             require("telescope.builtin").grep_string()
        --         end
        --     },
        --     {
        --         "<leader><leader>",
        --         function()
        --             require("telescope.builtin").oldfiles()
        --         end
        --     },
        -- },
    },
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
        end,
        keys = {
            { "<leader>a", function() require("harpoon"):list():add() end,                                    mode = "n", desc = "Harpoon add file" },
            { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, mode = "n", desc = "Harpoon quick menu" },
        },
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- list = { selection = { preselect = true } },

            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = 'super-tab',
                ["<CR>"] = { "accept", "fallback" },
                -- ["<Tab>"] = {
                --     function(cmp)
                --         if cmp.snippet_active() then
                --             cmp.select_next()
                --         end
                --     end, 'fallback'
                -- },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

            },

            cmdline = {
                keymap = {
                    ['<CR>'] = { 'accept', 'fallback' },
                },
                sources = {
                    'path', 'cmdline'

                    -- providers = {
                    --     path = {
                    --         opts = {
                    --             trailing_slash = false,
                    --             label_trailing_slash = false,
                    --             show_hidden_files_by_default = true,
                    --         }
                    --     }
                    -- }
                }
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = false },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },

                providers = {
                    path = {
                        opts = {
                            trailing_slash = false,
                            label_trailing_slash = false,
                            get_cwd = function(ctx)
                                return vim.fn.expand(("#%d:p:h"):format(ctx.bufnr))
                            end,
                            show_hidden_files_by_default = true,
                        }
                    }
                }
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
        },
    },
    {
        'Mofiqul/vscode.nvim'
    }

}
