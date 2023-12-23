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
	},
	{
		"simrat39/rust-tools.nvim",
		event = { "BufRead *.rs" },
		-- more config available in in the integration file(mason.lua)
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
