if !has('vim9script') ||  v:version < 900
    finish
endif
vim9script
g:loaded_vimbits = true

import '../autoload/vimbits/highlightonyank.vim' as hy
import '../autoload/vimbits/vim9cmdline.vim' as v9

if !exists(':ToggleVim9cmdline')
    command ToggleVim9cmdline {
        g:vimbits_vim9cmdline = !get(g:, 'vimbits_vim9cmdline', true)
    }
endif

augroup Vimbits | autocmd!
    if get(g:, 'vimbits_highlight_on_yank', true)
        autocmd TextYankPost * hy.HighlightedYank()
    endif
    if get(g:, 'vimbits_vim9cmdline', true)
        autocmd CmdlineEnter : v9.Vim9cmdlineSet()
        autocmd CmdlineLeave : v9.Vim9cmdlineUnset()
    endif
augroup END
