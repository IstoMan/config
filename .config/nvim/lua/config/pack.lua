if vim.pack == nil then
	error("This config uses vim.pack and requires Neovim 0.12 or newer.")
end

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/NeogitOrg/neogit" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
}, { load = true })

local function build_fzf_native()
	local plugin_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
	local lib = plugin_dir .. "/build/libfzf." .. (vim.uv.os_uname().sysname == "Darwin" and "dylib" or "so")

	if vim.fn.filereadable(lib) == 1 then
		return
	end

	if vim.fn.executable("make") == 0 then
		vim.notify("telescope-fzf-native.nvim needs `make` to build the fzf extension.", vim.log.levels.WARN)
		return
	end

	local result = vim.system({ "make" }, { cwd = plugin_dir, text = true }):wait()
	if result.code ~= 0 then
		vim.notify("Failed to build telescope-fzf-native.nvim:\n" .. (result.stderr or ""), vim.log.levels.WARN)
	end
end

build_fzf_native()

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme("catppuccin-nvim")

require("nvim-web-devicons").setup({
	color_icons = true,
	default = true,
	strict = true,
})

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
	win_options = {
		wrap = true,
	},
})

require("telescope").setup({})
pcall(require("telescope").load_extension, "fzf")

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				desc = desc,
				silent = true,
			})
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, "Next git hunk")

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, "Previous git hunk")

		map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
		map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selected hunk")
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset selected hunk")
		map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
		map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
		map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, "Blame line")
		map("n", "<leader>hd", gitsigns.diffthis, "Diff this")
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, "Diff this against last commit")
		map("n", "<leader>hq", gitsigns.setqflist, "Send hunks to quickfix")
		map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select git hunk")
	end,
})

require("neogit").setup({
	integrations = {
		telescope = true,
	},
})

require("flash").setup({})

require("mini.pairs").setup()

-- Surround: gs* prefix avoids conflict with Flash on `s`.
require("mini.surround").setup({
	mappings = {
		add = "gsa",
		delete = "gsd",
		replace = "gsr",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		suffix_next = "n",
		suffix_last = "l",
	},
})

require("mini.ai").setup()

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"ts_ls",
		"html",
		"cssls",
		"jsonls",
		"emmet_language_server",
		"clangd",
		"pyright",
		"lua_ls",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"goimports",
		"gofumpt",
		"isort",
		"black",
		"clang-format",
		"prettierd",
		"prettier",
	},
	run_on_start = true,
	start_delay = 3000,
})

local ts_parsers = {
	"go",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"c",
	"cpp",
	"python",
	"lua",
}

require("nvim-treesitter").setup({
	-- Keep Treesitter setup intentionally minimal on the new plugin rewrite.
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Ensure requested language parsers are present.
require("nvim-treesitter").install(ts_parsers)

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	completion = {
		documentation = { auto_show = true },
		menu = { auto_show = true },
	},
	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("gopls", {
	capabilities = capabilities,
	settings = {
		gopls = {
			symbolScope = "workspace",
		},
	},
})

for _, server in ipairs({
	"ts_ls",
	"html",
	"cssls",
	"jsonls",
	"emmet_language_server",
	"clangd",
	"pyright",
}) do
	vim.lsp.config(server, { capabilities = capabilities })
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		tsx = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		c = { "clang_format" },
		cpp = { "clang_format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("config.multicursor")
