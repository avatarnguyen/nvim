local snap = require 'snap'

-- snap.run {
--   producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
--   select = snap.get'select.file'.select,
--   multiselect = snap.get'select.file'.multiselect,
--   views = {snap.get'preview.file'}
-- }

snap.maps {
  -- { "<Leader>j", snap.config.file { producer = "ripgrep.file" } },
  { "<Leader>k", snap.config.file {
    producer = snap.get 'consumer.fzf' (snap.get 'producer.ripgrep.file'),
  }
  },
  { "<Leader>so", snap.config.file { producer = "vim.oldfile" } },
  { "<Leader>sm", snap.config.vimgrep {} },
}

-- Possible color config
-- highlight! link SnapSelect GruvboxBlue
-- highlight! link SnapMultiSelect GruvboxGray
-- highlight! link SnapNormal GruvboxFg1
-- highlight! link SnapBorder SnapNormal
-- highlight! link SnapPrompt GruvboxOrangeBold
-- highlight! link SnapPosition GruvboxOrangeBold
