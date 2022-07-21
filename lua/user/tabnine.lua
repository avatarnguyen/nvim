local cmp_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not cmp_status_ok then
  return
end

tabnine:setup({
	max_lines = 300;
	max_num_results = 4;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
    yaml = true,
		lua = true,
    log = true,
    TelescopePrompt = true,
    RenamePrompt = true,
    RenamerPrompt = true,
    renamer = true,
    Renamer = true,
    Rename = true,
    prompt = true,
	};
	show_prediction_strength = false;
})
