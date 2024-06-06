if !has('vim9script') ||  v:version < 900
    echoe "Needs Vim version 9.0 and above"
    finish
endif
vim9script

var id: number

hi def link FfTtSubtle Comment

def HighligtClear(): string
    if id > 0
        id->matchdelete()
        :redraw
        id = 0
    endif
    return ''
enddef

augroup fFtTHighlight | autocmd!
    autocmd CursorMoved,ModeChanged,TextChanged,WinEnter,WinLeave,CmdWinLeave,SafeState * HighligtClear()
augroup END

# Gather locations of characters to be dimmed.
def HighligtChars(s: string): string
    var [_, lnum, col, _] = getpos('.')
    var line = getline('.')
    # Extended ASCII characters can pose a challenge if we simply iterate over
    # bytes. It is preferable to let Vim split the line by characters for more
    # accurate handling.
    var found = {}
    for ch in line->split('\zs')
        if !found->has_key(ch)
            found[ch] = 1
        endif
    endfor

    var [start, reverse] = (s =~ '\C[ft]') ? [col, false] : [col - 2, true]
    var locations = []
    var freq = {}
    var maxloc = max([100, &lines * &columns])
    for ch in found->keys()
        var loc = reverse ? line->strridx(ch, start) : line->stridx(ch, start)
        while loc != -1
            freq[ch] = freq->get(ch, 0) + 1
            if freq[ch] != v:count1
                if freq[ch] > maxloc
                    # If we encounter a super long line, there's no need to
                    # search for locations most likely to be invisible.
                    break
                endif
                locations->add([lnum, loc + 1])
            endif
            loc = reverse ? line->strridx(ch, loc - 1) : line->stridx(ch, loc + 1)
        endwhile
    endfor

    if !locations->empty()
        if id > 0
            matchdelete(id)
        endif
        id = matchaddpos('FfTtSubtle', locations, 1001)
        :redraw
    endif
    return ''
enddef

if get(g:, 'vimbits_fFtT', true)
    noremap <silent><expr> <Plug>(fFtT-f) HighligtChars('f')
    noremap <silent><expr> <Plug>(fFtT-F) HighligtChars('F')
    noremap <silent><expr> <Plug>(fFtT-t) HighligtChars('t')
    noremap <silent><expr> <Plug>(fFtT-T) HighligtChars('T')
    noremap <silent><expr> <Plug>(fFtT-esc) HighligtClear()

    nnoremap f <Plug>(fFtT-f)f
    xnoremap f <Plug>(fFtT-f)f
    onoremap f <Plug>(fFtT-f)f
    nnoremap F <Plug>(fFtT-F)F
    xnoremap F <Plug>(fFtT-F)F
    onoremap F <Plug>(fFtT-F)F
    nnoremap t <Plug>(fFtT-t)t
    xnoremap t <Plug>(fFtT-t)t
    onoremap t <Plug>(fFtT-t)t
    nnoremap T <Plug>(fFtT-T)T
    xnoremap T <Plug>(fFtT-T)T
    onoremap T <Plug>(fFtT-T)T
    nnoremap <esc> <Plug>(fFtT-esc)<esc>
    xnoremap <esc> <Plug>(fFtT-esc)<esc>
    onoremap <esc> <Plug>(fFtT-esc)<esc>
endif
