if !has('vim9script') ||  v:version < 900
    finish
endif
vim9script
g:loaded_vimbits = true

import '../autoload/vimbits/highlightonyank.vim' as hy
import '../autoload/vimbits/vim9cmdline.vim' as v9

if get(g:, 'vimbits_vim9cmdline', false) && !exists(':ToggleVim9Cmdline')
    command ToggleVim9Cmdline {
        g:vimbits_vim9cmdline = !get(g:, 'vimbits_vim9cmdline', false)
    }
endif

augroup Vimbits | autocmd!
    if get(g:, 'vimbits_highlightonyank', true)
        autocmd TextYankPost * hy.HighlightOnYank()
    endif
    if get(g:, 'vimbits_vim9cmdline', false)
        autocmd CmdlineEnter : v9.Vim9cmdlineSet()
        autocmd CmdlineLeave : v9.Vim9cmdlineUnset()
    endif
augroup END
