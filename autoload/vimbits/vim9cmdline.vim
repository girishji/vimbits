vim9script

export def Vim9cmdlineSet()
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
enddef

export def Vim9cmdlineUnset()
    cunmap <c-u>
    cunmap <c-w>
    cunmap <c-b>
    cunmap <c-left>
    cunmap <bs>
    cunmap <left>
enddef
