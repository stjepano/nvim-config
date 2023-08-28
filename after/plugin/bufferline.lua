local bufferline = require('bufferline')
bufferline.setup {
  options = {
    style_preset = bufferline.style_preset.default,
    numbers = "none",
    separator_style = "thin",
  },
  highlights = {
    buffer_selected = {
      fg = "#ffa500",
      bold = true,
    },
  },
}
