-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/anhknowunity/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/anhknowunity/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/anhknowunity/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/anhknowunity/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/anhknowunity/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  camelcasemotion = {
    config = { "\27LJ\2\n7\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\6\\\24camelcasemotion_key\6g\bvim\0" },
    loaded = true,
    path = "/Users/anhknowunity/.local/share/nvim/site/pack/packer/start/camelcasemotion",
    url = "https://github.com/bkad/camelcasemotion"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\nÙ\1\0\0\a\0\r\0\0266\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\1\0009\1\4\0015\4\v\0004\5\4\0009\6\5\0009\6\6\0069\6\a\6>\6\1\0059\6\5\0009\6\6\0069\6\b\6>\6\2\0059\6\t\0009\6\6\0069\6\n\6>\6\3\5=\5\f\4B\1\3\1K\0\1\0\fdefault\1\0\0\tbool\rconstant\bhex\fdecimal\nalias\finteger\19register_group\faugends\16dial.config\16dial.augend\frequire\0" },
    loaded = true,
    path = "/Users/anhknowunity/.local/share/nvim/site/pack/packer/start/dial.nvim",
    url = "https://github.com/monaqa/dial.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/anhknowunity/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18user.surround\frequire\0" },
    loaded = true,
    path = "/Users/anhknowunity/.local/share/nvim/site/pack/packer/start/surround.nvim",
    url = "https://github.com/Mephistophiles/surround.nvim"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/anhknowunity/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18user.surround\frequire\0", "config", "surround.nvim")
time([[Config for surround.nvim]], false)
-- Config for: camelcasemotion
time([[Config for camelcasemotion]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\6\\\24camelcasemotion_key\6g\bvim\0", "config", "camelcasemotion")
time([[Config for camelcasemotion]], false)
-- Config for: dial.nvim
time([[Config for dial.nvim]], true)
try_loadstring("\27LJ\2\nÙ\1\0\0\a\0\r\0\0266\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\1\0009\1\4\0015\4\v\0004\5\4\0009\6\5\0009\6\6\0069\6\a\6>\6\1\0059\6\5\0009\6\6\0069\6\b\6>\6\2\0059\6\t\0009\6\6\0069\6\n\6>\6\3\5=\5\f\4B\1\3\1K\0\1\0\fdefault\1\0\0\tbool\rconstant\bhex\fdecimal\nalias\finteger\19register_group\faugends\16dial.config\16dial.augend\frequire\0", "config", "dial.nvim")
time([[Config for dial.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
