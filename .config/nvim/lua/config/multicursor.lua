local mc = require("multicursor-nvim")

mc.setup()

local set = vim.keymap.set

-- Add or skip cursor above/below the main cursor.
set({ "n", "x" }, "<up>", function()
  mc.lineAddCursor(-1)
end, { desc = "Add cursor on line above", silent = true })
set({ "n", "x" }, "<down>", function()
  mc.lineAddCursor(1)
end, { desc = "Add cursor on line below", silent = true })
set({ "n", "x" }, "<leader><up>", function()
  mc.lineSkipCursor(-1)
end, { desc = "Skip cursor on line above", silent = true })
set({ "n", "x" }, "<leader><down>", function()
  mc.lineSkipCursor(1)
end, { desc = "Skip cursor on line below", silent = true })

-- Add or skip cursors by matching word/selection.
set({ "n", "x" }, "gn", function()
  mc.matchAddCursor(1)
end, { desc = "Add cursor at next match", silent = true })
set({ "n", "x" }, "gN", function()
  mc.matchAddCursor(-1)
end, { desc = "Add cursor at previous match", silent = true })
set({ "n", "x" }, "gm", function()
  mc.matchSkipCursor(1)
end, { desc = "Skip next match for cursor", silent = true })
set({ "n", "x" }, "gM", function()
  mc.matchSkipCursor(-1)
end, { desc = "Skip previous match for cursor", silent = true })
set({ "n", "x" }, "gA", mc.matchAllAddCursors, { desc = "Add cursors at all matches", silent = true })

-- Add and remove cursors with control + left click.
set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Multicursor mouse add", silent = true })
set("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "Multicursor mouse drag", silent = true })
set("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "Multicursor mouse release", silent = true })

-- Disable and enable cursors.
set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle multicursor", silent = true })

-- Mappings defined in a keymap layer only apply when there are multiple cursors.
mc.addKeymapLayer(function(layerSet)
  layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Previous multicursor", silent = true })
  layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Next multicursor", silent = true })
  layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete multicursor", silent = true })
  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end, { desc = "Clear or enable multicursors", silent = true })
end)

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
