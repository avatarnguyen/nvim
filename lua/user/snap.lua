local snap = require'snap'

-- snap.run {
--   producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
--   select = snap.get'select.file'.select,
--   multiselect = snap.get'select.file'.multiselect,
--   views = {snap.get'preview.file'}
-- }

snap.maps {
  -- {"<Leader>ff", snap.config.file {producer = "ripgrep.file"}},
  {"<Leader>k", snap.config.file {
      producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
      select = snap.get'select.file'.select,
      -- multiselect = snap.get'select.file'.multiselect,
    }
  },
  {"<Leader>so", snap.config.file {producer = "vim.oldfile"}},
  {"<Leader>sl", snap.config.vimgrep {}},
}
