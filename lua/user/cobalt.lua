  -- require('colorbuddy').setup()
  require('colorbuddy').colorscheme('cobalt2')
  local utils = require("cobalt2.utils")
  local c = utils.colors
  --require("cobalt2.utils").Group.new("Cursor", c.cobalt_bg, c.yellow, nil)
  -- Group.new('italicBoldFunction', colors.green, groups.Function, styles.bold + styles.italic)
  utils.Group.new('Normal', c.none, c.none, nil)
