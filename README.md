# cmp-diag-codes

Simple completion for diagnostic codes, useful for disable some codes.

# Usage

```lua
require("cmp").setup({
  -- other settings
  sources = {
    {
        name = "diag-codes",
        -- default completion available only in comment context
        -- use false if you want to get in other context
        option = { in_comment = true }
    },
  },
})

