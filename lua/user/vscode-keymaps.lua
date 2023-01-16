local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<Left>", function() vim.fn.VSCodeNotify("workbench.action.focusLeftGroup") end, opts)
keymap("n", "<Down>", function() vim.fn.VSCodeNotify("workbench.action.focusBelowGroup") end, opts)
keymap("n", "<Up>", function() vim.fn.VSCodeNotify("workbench.action.focusAboveGroup") end, opts)
keymap("n", "<Right>", function() vim.fn.VSCodeNotify("workbench.action.focusRightGroup") end, opts)

keymap("n", "gj", function() vim.fn.VSCodeNotify("editor.action.peekDefinition") end, opts)
keymap("n", "gs", function() vim.fn.VSCodeNotify("editor.action.triggerParameterHints") end, opts)
keymap("n", "gk", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end, opts)
keymap("n", "gl", function() vim.fn.VSCodeNotify("editor.action.peakDeclaration") end, opts)
keymap("n", "gu", function() vim.fn.VSCodeNotify("editor.action.goToReferences") end, opts)
keymap("n", "gm", function() vim.fn.VSCodeNotify("editor.action.goToImplementation") end, opts)

keymap("n", "ge", function() vim.fn.VSCodeNotify("editor.action.marker.nextInFiles") end, opts)
keymap("n", "gE", function() vim.fn.VSCodeNotify("editor.action.marker.prevInFiles") end, opts)
keymap("n", "]e", function() vim.fn.VSCodeNotify("editor.action.marker.next") end, opts)
keymap("n", "[e", function() vim.fn.VSCodeNotify("editor.action.marker.prev") end, opts)
-- keymap("n", "E", function() vim.fn.VSCodeNotify("workbench.actions.workbench.panel.markers.view.toggleErrors") end, opts)

keymap("n", "<leader>r", function() vim.fn.VSCodeNotify("editor.action.rename") end, opts)
keymap("n", "<leader>n", function() vim.fn.VSCodeNotify("fileutils.renameFile") end, opts)
keymap("n", "<leader>f", function() vim.fn.VSCodeNotify("workbench.action.quickOpen") end, opts)
keymap("n", "<leader>a", function() vim.fn.VSCodeNotify("workbench.action.showCommands") end, opts)
vim.keymap.set("n", "<leader>e", function() vim.fn.VSCodeNotify("workbench.action.problems.focus") end)
vim.keymap.set("n", "<leader>g", function() vim.fn.VSCodeNotify("workbench.view.scm") end)

-- keymap("n", "<C-d>", "<C-d>zz", opts)
-- keymap("n", "<C-u>", "<C-u>zz", opts)

-- Clear highlights
keymap("n", "<C-n>", "<cmd>nohlsearch<CR>", opts)

-- copy and paste
keymap("n", "<leader>p", '"0p', opts)
keymap("v", "<leader>p", '"_dP', opts)

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, silent = true })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, silent = true })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, silent = true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, silent = true })

-- Dial
keymap("n", "<C-a>", require("dial.map").inc_normal())
keymap("n", "<C-x>", require("dial.map").dec_normal())
keymap("v", "<C-a>", require("dial.map").inc_visual())
keymap("v", "<C-x>", require("dial.map").dec_visual())
keymap("v", "g<C-a>", require("dial.map").inc_gvisual())
keymap("v", "g<C-x>", require("dial.map").dec_gvisual())

-- SUBSTITUTE plugin  {{{
keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
--keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
--keymap("n", "<S-s>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
--keymap("v", "<S-s>", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
--keymap("n", "<leader>r", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
--keymap("x", "<leader>r", "<cmd>lua require('substitute.range').visual()<cr>", {})
--keymap("n", "<leader>rr", "<cmd>lua require('substitute.range').word()<cr>", {})
--}}}

-- Comment
keymap("v", "gc",
  function()
    vim.fn.VSCodeNotifyVisual("editor.action.commentLine", true)
    -- vim.cmd("Esc")
  end)
keymap("n", "gcc", function() vim.fn.VSCodeNotify("editor.action.commentLine", true) end)
-- Visual remaps
-- keymap("v", "gs", function() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end)
keymap("v", "<", function() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end)
keymap("v", ">", function() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end)


-- Folding
vim.keymap.set("n", "za", function() vim.fn.VSCodeNotify("editor.toggleFold") end)
vim.keymap.set("n", "zc", function() vim.fn.VSCodeNotify("editor.foldRecursively") end)
vim.keymap.set("n", "zC", function() vim.fn.VSCodeNotify("editor.foldAll") end)
vim.keymap.set("n", "zO", function() vim.fn.VSCodeNotify("editor.unfoldAll") end)
vim.keymap.set("n", "zo", function() vim.fn.VSCodeNotify("editor.unfoldRecursively") end)
vim.keymap.set("n", "zp", function() vim.fn.VSCodeNotify("editor.gotoParentFold") end)

-- FILE COMMANDS
--
vim.cmd [[
function! s:editOrNew(...)
  let file = a:1
  let bang = a:2

  if empty(file)
      if bang ==# '!'
          call VSCodeNotify('workbench.action.files.revert')
      else
          call VSCodeNotify('workbench.action.quickOpen')
      endif
  else
      " Last arg is to close previous file, e.g. e! ~/blah.txt will open blah.txt instead the current file
      call VSCodeExtensionNotify('open-file', expand(file), bang ==# '!' ? 1 : 0)
  endif
endfunction

function! s:saveAndClose() abort
  call VSCodeCall('workbench.action.files.save')
  call VSCodeNotify('workbench.action.closeActiveEditor')
endfunction

function! s:saveAllAndClose() abort
  call VSCodeCall('workbench.action.files.saveAll')
  call VSCodeNotify('workbench.action.closeAllEditors')
endfunction

" command! -bang -nargs=? Edit call VSCodeCall('workbench.action.quickOpen')
command! -complete=file -bang -nargs=? Edit call <SID>editOrNew(<q-args>, <q-bang>)
command! -bang -nargs=? Ex call <SID>editOrNew(<q-args>, <q-bang>)
command! -bang Enew call <SID>editOrNew('__vscode_new__', <q-bang>)
command! -bang Find call VSCodeNotify('workbench.action.quickOpen')

command! -complete=file -bang -nargs=? Write if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.files.saveAs') | else | call VSCodeNotify('workbench.action.files.save') | endif
command! -bang Saveas call VSCodeNotify('workbench.action.files.saveAs')

command! -bang Wall call VSCodeNotify('workbench.action.files.saveAll')
command! -bang Quit if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.revertAndCloseActiveEditor') | else | call VSCodeNotify('workbench.action.closeActiveEditor') | endif

command! -bang Wq call <SID>saveAndClose()
command! -bang Xit call <SID>saveAndClose()

command! -bang Qall call VSCodeNotify('workbench.action.closeAllEditors')

command! -bang Wqall call <SID>saveAllAndClose()
command! -bang Xall call <SID>saveAllAndClose()

AlterCommand e[dit] Edit
AlterCommand ex Ex
AlterCommand ene[w] Enew
AlterCommand fin[d] Find
AlterCommand w[rite] Write
AlterCommand sav[eas] Saveas
AlterCommand wa[ll] Wall
AlterCommand q[uit] Quit
AlterCommand wq Wq
AlterCommand x[it] Xit
AlterCommand qa[ll] Qall
AlterCommand wqa[ll] Wqall
AlterCommand xa[ll] Xall

nnoremap ZZ <Cmd>Wq<CR>
nnoremap ZQ <Cmd>Quit!<CR>

]]

-- SCROLLING COMMANDS
vim.cmd [[
function s:reveal(direction, resetCursor)
  call VSCodeExtensionNotify('reveal', a:direction, a:resetCursor)
endfunction

nnoremap z<CR> <Cmd>call <SID>reveal('top', 1)<CR>
xnoremap z<CR> <Cmd>call <SID>reveal('top', 1)<CR>
nnoremap zt <Cmd>call <SID>reveal('top', 0)<CR>
xnoremap zt <Cmd>call <SID>reveal('top', 0)<CR>
nnoremap z. <Cmd>call <SID>reveal('center', 1)<CR>
xnoremap z. <Cmd>call <SID>reveal('center', 1)<CR>
nnoremap zz <Cmd>call <SID>reveal('center', 0)<CR>
xnoremap zz <Cmd>call <SID>reveal('center', 0)<CR>
nnoremap z- <Cmd>call <SID>reveal('bottom', 1)<CR>
xnoremap z- <Cmd>call <SID>reveal('bottom', 1)<CR>
nnoremap zb <Cmd>call <SID>reveal('bottom', 0)<CR>
xnoremap zb <Cmd>call <SID>reveal('bottom', 0)<CR>


function s:moveCursor(to)
  " Native VSCode commands don't register jumplist. Fix by registering jumplist in Vim e.g. for subsequent use of <C-o>
  normal! m'
  call VSCodeExtensionNotify('move-cursor', a:to)
endfunction

nnoremap H <Cmd>call <SID>moveCursor('top')<CR>
xnoremap H <Cmd>call <SID>moveCursor('top')<CR>
nnoremap M <Cmd>call <SID>moveCursor('middle')<CR>
xnoremap M <Cmd>call <SID>moveCursor('middle')<CR>
nnoremap L <Cmd>call <SID>moveCursor('bottom')<CR>
xnoremap L <Cmd>call <SID>moveCursor('bottom')<CR>
]]

-- TAB COMMANDS
vim.cmd [[
function! s:switchEditor(...) abort
    let count = a:1
    let direction = a:2
    for i in range(1, count ? count : 1)
        call VSCodeCall(direction ==# 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
    endfor
endfunction

command! -complete=file -nargs=? Tabedit if empty(<q-args>) | call VSCodeNotify('workbench.action.quickOpen') | else | call VSCodeExtensionNotify('open-file', expand(<q-args>), 0) | endif
command! -complete=file -nargs=? Tabnew call VSCodeExtensionNotify('open-file', '__vscode_new__', 0)
command! Tabfind call VSCodeNotify('workbench.action.quickOpen')
command! Tab echoerr 'Not supported'
command! Tabs echoerr 'Not supported'
command! -bang Tabclose if <q-bang> ==# '!' | call VSCodeNotify('workbench.action.revertAndCloseActiveEditor') | else | call VSCodeNotify('workbench.action.closeActiveEditor') | endif
command! Tabonly call VSCodeNotify('workbench.action.closeOtherEditors')
command! -nargs=? Tabnext call <SID>switchEditor(<q-args>, 'next')
command! -nargs=? Tabprevious call <SID>switchEditor(<q-args>, 'prev')
command! Tabfirst call VSCodeNotify('workbench.action.firstEditorInGroup')
command! Tablast call VSCodeNotify('workbench.action.lastEditorInGroup')
command! Tabrewind call VSCodeNotify('workbench.action.firstEditorInGroup')
command! -nargs=? Tabmove echoerr 'Not supported yet'

AlterCommand tabe[dit] Tabedit
AlterCommand tabnew Tabnew
AlterCommand tabf[ind] Tabfind
AlterCommand tab Tab
AlterCommand tabs Tabs
AlterCommand tabc[lose] Tabclose
AlterCommand tabo[nly] Tabonly
AlterCommand tabn[ext] Tabnext
AlterCommand tabp[revious] Tabprevious
AlterCommand tabr[ewind] Tabrewind
AlterCommand tabfir[st] Tabfirst
AlterCommand tabl[ast] Tablast
AlterCommand tabm[ove] Tabmove

nnoremap <Tab> <Cmd>call <SID>switchEditor(v:count, 'next')<CR>
xnoremap gt <Cmd>call <SID>switchEditor(v:count, 'next')<CR>
nnoremap <S-Tab> <Cmd>call <SID>switchEditor(v:count, 'prev')<CR>
xnoremap gT <Cmd>call <SID>switchEditor(v:count, 'prev')<CR>
]]

-- WINDOWS COMMANDS
vim.cmd [[
  function! s:split(...) abort
      let direction = a:1
      let file = exists('a:2') ? a:2 : ''
      call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
      if !empty(file)
          call VSCodeExtensionNotify('open-file', expand(file), 'all')
      endif
  endfunction

  function! s:splitNew(...)
      let file = a:2
      call s:split(a:1, empty(file) ? '__vscode_new__' : file)
  endfunction

  function! s:closeOtherEditors()
      call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
      call VSCodeNotify('workbench.action.closeOtherEditors')
  endfunction

  function! s:manageEditorHeight(...)
      let count = a:1
      let to = a:2
      for i in range(1, count ? count : 1)
          call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewHeight' : 'workbench.action.decreaseViewHeight')
      endfor
  endfunction

  function! s:manageEditorWidth(...)
      let count = a:1
      let to = a:2
      for i in range(1, count ? count : 1)
          call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewWidth' : 'workbench.action.decreaseViewWidth')
      endfor
  endfunction

  command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
  command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
  command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
  command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
  command! -bang Only if <q-bang> ==# '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

  AlterCommand sp[lit] Split
  AlterCommand vs[plit] Vsplit
  AlterCommand new New
  AlterCommand vne[w] Vnew
  AlterCommand on[ly] Only

  " buffer management
  nnoremap <C-w>n <Cmd>call <SID>splitNew('h', '__vscode_new__')<CR>
  xnoremap <C-w>n <Cmd>call <SID>splitNew('h', '__vscode_new__')<CR>

  nnoremap <C-w>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  xnoremap <C-w>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  nnoremap <C-w>c <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  xnoremap <C-w>c <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  nnoremap <C-w><C-c> <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  xnoremap <C-w><C-c> <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

  " window/splits management
  nnoremap <C-w>s <Cmd>call <SID>split('h')<CR>
  xnoremap <C-w>s <Cmd>call <SID>split('h')<CR>
  nnoremap <C-w><C-s> <Cmd>call <SID>split('h')<CR>
  xnoremap <C-w><C-s> <Cmd>call <SID>split('h')<CR>

  nnoremap <C-w>v <Cmd>call <SID>split('v')<CR>
  xnoremap <C-w>v <Cmd>call <SID>split('v')<CR>
  nnoremap <C-w><C-v> <Cmd>call <SID>split('v')<CR>
  xnoremap <C-w><C-v> <Cmd>call <SID>split('v')<CR>

  nnoremap <C-w>= <Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
  xnoremap <C-w>= <Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
  nnoremap <C-w>_ <Cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
  xnoremap <C-w>_ <Cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

  nnoremap <C-w>+ <Cmd>call <SID>manageEditorHeight(v:count, 'increase')<CR>
  xnoremap <C-w>+ <Cmd>call <SID>manageEditorHeight(v:count, 'increase')<CR>
  nnoremap <C-w>- <Cmd>call <SID>manageEditorHeight(v:count, 'decrease')<CR>
  xnoremap <C-w>- <Cmd>call <SID>manageEditorHeight(v:count, 'decrease')<CR>
  nnoremap <C-w>> <Cmd>call <SID>manageEditorWidth(v:count,  'increase')<CR>
  xnoremap <C-w>> <Cmd>call <SID>manageEditorWidth(v:count,  'increase')<CR>
  nnoremap <C-w>< <Cmd>call <SID>manageEditorWidth(v:count,  'decrease')<CR>
  xnoremap <C-w>< <Cmd>call <SID>manageEditorWidth(v:count,  'decrease')<CR>

  nnoremap <C-w>o <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
  xnoremap <C-w>o <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
  nnoremap <C-w><C-o> <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
  xnoremap <C-w><C-o> <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>

  " window navigation
  nnoremap <C-w>j <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  xnoremap <C-w>j <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  nnoremap <C-w>k <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  xnoremap <C-w>k <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  nnoremap <C-w>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  xnoremap <C-w>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  nnoremap <C-w>l <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
  xnoremap <C-w>l <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

  nnoremap <C-w><Down> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  xnoremap <C-w><Down> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  nnoremap <C-w><Up> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  xnoremap <C-w><Up> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  nnoremap <C-w><Left> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  xnoremap <C-w><Left> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  nnoremap <C-w><Right> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
  xnoremap <C-w><Right> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

  nnoremap <C-w><C-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
  xnoremap <C-w><C-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
  nnoremap <C-w><C-i> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
  xnoremap <C-w><C-i> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
  nnoremap <C-w><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
  xnoremap <C-w><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
  nnoremap <C-w><C-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
  xnoremap <C-w><C-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

  nnoremap <C-w><C-Down> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
  xnoremap <C-w><C-Down> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
  nnoremap <C-w><C-Up> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
  xnoremap <C-w><C-Up> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
  nnoremap <C-w><C-Left> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
  xnoremap <C-w><C-Left> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
  nnoremap <C-w><C-Right> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
  xnoremap <C-w><C-Right> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

  nnoremap <C-w><S-j> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
  xnoremap <C-w><S-j> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
  nnoremap <C-w><S-k> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
  xnoremap <C-w><S-k> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
  nnoremap <C-w><S-h> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
  xnoremap <C-w><S-h> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
  nnoremap <C-w><S-l> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>
  xnoremap <C-w><S-l> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>

  nnoremap <C-w><S-Down> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
  xnoremap <C-w><S-Down> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
  nnoremap <C-w><S-Up> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
  xnoremap <C-w><S-Up> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
  nnoremap <C-w><S-Left> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
  xnoremap <C-w><S-Left> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
  nnoremap <C-w><S-Right> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>
  xnoremap <C-w><S-Right> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>

  nnoremap <C-w>w <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
  xnoremap <C-w>w <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
  nnoremap <C-w><C-w> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
  xnoremap <C-w><C-w> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
  nnoremap <C-w>W <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
  xnoremap <C-w>W <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
  nnoremap <C-w>p <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
  xnoremap <C-w>p <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>

  nnoremap <C-w>t <Cmd>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
  xnoremap <C-w>t <Cmd>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
  nnoremap <C-w>b <Cmd>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>
  xnoremap <C-w>b <Cmd>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>
]]
