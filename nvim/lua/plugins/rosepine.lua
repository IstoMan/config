-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
    require("rose-pine").setup({
    variant = "moon", -- auto, main, moon, or dawn
    })
		-- vim.cmd("colorscheme rose-pine")
	end
}

