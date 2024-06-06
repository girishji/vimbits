if !has('vim9script') ||  v:version < 900
    echoe "Needs Vim version 9.0 and above"
    finish
endif
vim9script

# Jump to any character on screen using 2 characters.

:highlight default link EasyJump MatchParen

import autoload '../autoload/vimbits/jump.vim'

def Jump(count: number = 1)
    jump.Jump(count == 2)
enddef

def VJump(count: number = 1)
    jump.Jump(count == 2)
    :normal! m'gv``
enddef

if get(g:, 'vimbits_easyjump', true)
    :nnoremap <silent> <Plug>EasyjumpJump; :<c-u>call <SID>Jump(v:count1)<cr>
    :onoremap <silent> <Plug>EasyjumpJump; :<c-u>call <SID>Jump(v:count1)<cr>
    :vnoremap <silent> <Plug>EasyjumpJump; :<c-u>call <SID>VJump(v:count1)<cr>

    augroup VimbitsEasyJump | autocmd!
        autocmd VimEnter * jump.Setup()
    augroup END
else
    :nnoremap <silent> <Plug>EasyjumpJump; :echo 'EasyJump not enabled'<cr>
    :onoremap <silent> <Plug>EasyjumpJump; :echo 'EasyJump not enabled'<cr>
    :vnoremap <silent> <Plug>EasyjumpJump; :echo 'EasyJump not enabled'<cr>
endif

def EasyJumpJump()
    if mode() == "\<C-V>" || mode() =~ '\v(v|V)'
        VJump()
    elseif mode() =~ '\v(n|no)'
        Jump()
    endif
enddef

if get(g:, 'easyjump_command', false) && !exists(':EasyJump')
    command EasyJump EasyJumpJump()
endif
