require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- DAP (Debugging) keymaps
map("n", "<F5>", function() require('dap').continue() end, { desc = "Debug: Start/Continue" })
map("n", "<F10>", function() require('dap').step_over() end, { desc = "Debug: Step Over" })
map("n", "<F11>", function() require('dap').step_into() end, { desc = "Debug: Step Into" })
map("n", "<F12>", function() require('dap').step_out() end, { desc = "Debug: Step Out" })
map("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function() require('dap').set_breakpoint() end, { desc = "Debug: Set Breakpoint" })
map("n", "<leader>dr", function() require('dap').repl.open() end, { desc = "Debug: Open REPL" })
map("n", "<leader>dl", function() require('dap').run_last() end, { desc = "Debug: Run Last" })
map("n", "<leader>du", function() require('dapui').toggle() end, { desc = "Debug: Toggle UI" })

-- LSP keymaps (additional to the ones in lspconfig.lua)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "LSP: Format" })

-- TypeScript specific
map("n", "<leader>to", "<cmd>TypescriptOrganizeImports<cr>", { desc = "TS: Organize Imports" })
map("n", "<leader>tr", "<cmd>TypescriptRemoveUnused<cr>", { desc = "TS: Remove Unused" })
map("n", "<leader>tf", "<cmd>TypescriptFixAll<cr>", { desc = "TS: Fix All" })

-- Package.json utilities  
map("n", "<leader>ns", "<cmd>PackageInfoShow<cr>", { desc = "Package: Show Info" })
map("n", "<leader>nc", "<cmd>PackageInfoHide<cr>", { desc = "Package: Hide Info" })
map("n", "<leader>nt", "<cmd>PackageInfoToggle<cr>", { desc = "Package: Toggle Info" })
map("n", "<leader>nu", "<cmd>PackageInfoUpdate<cr>", { desc = "Package: Update" })
map("n", "<leader>nd", "<cmd>PackageInfoDelete<cr>", { desc = "Package: Delete" })
map("n", "<leader>ni", "<cmd>PackageInfoInstall<cr>", { desc = "Package: Install" })
map("n", "<leader>np", "<cmd>PackageInfoChangeVersion<cr>", { desc = "Package: Change Version" })

-- Python virtual environment
map("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Python: Select Venv" })
