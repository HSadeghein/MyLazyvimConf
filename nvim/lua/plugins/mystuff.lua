return
{
    {
        "snacks.nvim",
        opts = {
            scroll = { enabled = false },
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require('telescope').setup({
                defaults = {
                    sorting_strategy = 'ascending',
                    file_ignore_patterns = { "node_modules", ".git/" },
                },
                pickers = {
                    buffers = {
                        sort_mru = true,
                        sort_lastused = true,
                        ignore_current_buffer = true,
                        mappings = {
                            i = {
                                ["<C-d>"] = "delete_buffer",
                            },
                            n = {
                                ["<C-d>"] = "delete_buffer",
                            }
                        }
                    }
                }
            })

            local builtin = require('telescope.builtin')
            -- vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
            vim.keymap.set('n', '<leader><leader>', LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), {})

            -- VS Code-style Ctrl+Tab buffer navigation with telescope picker
            local function show_buffer_picker(direction)
                local picker_opts = {
                    sort_mru = true,
                    sort_lastused = true,
                    ignore_current_buffer = false,
                    path_display = function(_, path)
                        local cwd = vim.fn.getcwd()
                        local rel_path = vim.fn.fnamemodify(path, ":.")
                        local tail = require("telescope.utils").path_tail(path)
                        return string.format("%s (%s)", tail, rel_path)
                    end,
                    -- only_cwd = true,
                    initial_mode = 'normal',
                    prompt_title = 'Recent Buffers',
                    attach_mappings = function(prompt_bufnr, map)
                        local actions = require('telescope.actions')
                        local action_state = require('telescope.actions.state')

                        -- Override default selection to close immediately
                        map('n', '<CR>', function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            if selection then
                                vim.api.nvim_set_current_buf(selection.bufnr)
                            end
                        end)


                        -- Allow continuing to cycle
                        map('n', '<C-Tab>', function()
                            actions.move_selection_next(prompt_bufnr)
                        end)

                        map('n', '<C-S-Tab>', function()
                            actions.move_selection_previous(prompt_bufnr)
                        end)

                        return true
                    end,
                    layout_config = {
                        height = 0.4,
                        width = 0.6,
                        prompt_position = "top",
                    },
                }

                if direction == 'prev' then
                    -- For reverse direction, we'll start from the second item
                    picker_opts.default_selection_index = 2
                end

                builtin.buffers(picker_opts)
            end

            vim.keymap.set('n', '<C-Tab>', function()
                show_buffer_picker('next')
            end, { desc = 'Switch between recent buffers (VS Code style)' })

            vim.keymap.set('n', '<C-S-Tab>', function()
                show_buffer_picker('prev')
            end, { desc = 'Switch between recent buffers in reverse order' })
        end,
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
    },
    {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = function()
            require('ufo').setup(
                {
                    provider_selector = function(bufnr, filetype, buftype)
                        return { 'lsp', 'indent' }
                    end,
                    preview = {
                        win_config = {
                            border = { '', '─', '', '', '', '─', '', '' },
                            winhighlight = 'Normal:Folded',
                            winblend = 0
                        },
                    },
                    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                        local newVirtText = {}
                        local suffix = (' *** %d lines'):format(endLnum - lnum)
                        local sufWidth = vim.fn.strdisplaywidth(suffix)
                        local targetWidth = width - sufWidth
                        local curWidth = 0
                        for _, chunk in ipairs(virtText) do
                            local chunkText = chunk[1]
                            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            if targetWidth > curWidth + chunkWidth then
                                table.insert(newVirtText, chunk)
                            else
                                chunkText = truncate(chunkText, targetWidth - curWidth)
                                local hlGroup = chunk[2]
                                table.insert(newVirtText, { chunkText, hlGroup })
                                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                                if curWidth + chunkWidth < targetWidth then
                                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                                end
                                break
                            end
                            curWidth = curWidth + chunkWidth
                        end
                        table.insert(newVirtText, { suffix, 'LineNr' })
                        return newVirtText
                    end
                }
            )
        end,
    },
    { 'kevinhwang91/promise-async' },
    {
        'motiongorilla/p4nvim',
    }

}
