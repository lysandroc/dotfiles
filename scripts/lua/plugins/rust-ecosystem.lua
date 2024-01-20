return {
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			src = {
				cmp = {
					enabled = true,
				},
			},
		},
		-- also depends taplo from mason
		keys = {
			{
				"K",
				function()
					if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
						require("crates").show_popup()
					else
						vim.lsp.buf.hover()
					end
				end,
				desc = "Show Crate Documentation",
			},
		},
	},
	{
		"simrat39/rust-tools.nvim",
		event = { "BufRead *.rs" },
		-- more config available in in the integration file(mason.lua)
		keys = {
			{
				"<leader>dr",
				"<cmd>RustDebuggables<cr>",
				desc = "Run Debuggables (Rust)",
			},
			{
				"<leader>lm",
				"<cmd>RustExpandMacro<cr>",
				desc = "Expand Macro (Rust)",
			},
			{
				"<leader>lH",
				"<cmd>RustToggleInlayHints<cr>",
				desc = "Toggle Inlay Hints (Rust)",
			},
			{
				"<leader>le",
				"<cmd>RustRunnables<cr>",
				desc = "Runnables (Rust)",
			},
			{
				"<leader>lh",
				"<cmd>RustHoverActions<cr>",
				desc = "Hover Actions (Rust)",
			},
		},
		config = function()
		end,
		dependencies = {
			-- runnables dependes on this package
			"akinsho/toggleterm.nvim",
		},
	},
	{ "rouge8/neotest-rust" },
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"rouge8/neotest-rust",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				["neotest-rust"] = {},
			},
		},
	},
}
