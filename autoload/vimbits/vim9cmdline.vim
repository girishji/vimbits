vim9script

export def Vim9cmdlineSet()
    if get(g:, 'vimbits_vim9cmdline', false)
        if visualmode() == null_string
            setcmdline('vim9 ')
        else
            setcmdline('vim9 :')
            visualmode(1)
        endif
        cnoremap        <c-u>    <c-u>vim9<space>
        cnoremap        <c-b>    <c-b><c-right><right>
        cnoremap <expr> <c-w>    getcmdpos() > 6 ? "\<c-w>" : ""
        cnoremap <expr> <c-left> getcmdpos() > 6 ? "\<c-left>" : ""
        cnoremap <expr> <bs>     getcmdpos() > 6 ? "\<bs>" : ""
        cnoremap <expr> <left>   getcmdpos() > 6 ? "\<left>" : ""
    endif
enddef

export def Vim9cmdlineUnset()
    if get(g:, 'vimbits_vim9cmdline', false)
        silent! cunmap <c-u>
        silent! cunmap <c-w>
        silent! cunmap <c-b>
        silent! cunmap <c-left>
        silent! cunmap <bs>
        silent! cunmap <left>
    endif
enddef
