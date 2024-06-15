vim9script

# hlgroup: Highlight group used for highlighting yanked region.
# duration: Duration of highlight in milliseconds.
# in_visual: Whether to highlight the region if selected from visual mode.
export def HighlightOnYank(hlgroup = 'IncSearch', duration = 300, in_visual = true)
    if v:event.operator ==? 'y'
        if !in_visual && visualmode() != null_string
            visualmode(1)
            return
        endif
        var [beg, end] = [getpos("'["), getpos("']")]
        var type = v:event.regtype ?? 'v'
        var pos = getregionpos(beg, end, {type: type})
        var end_offset = (type == 'V' || v:event.inclusive) ? 1 : 0
        var m = matchaddpos(hlgroup, pos->mapnew((_, v) => {
            var col_beg = v[0][2] + v[0][3]
            var col_end = v[1][2] + v[1][3] + end_offset
            return [v[0][1], col_beg, col_end - col_beg]
        }))
        var winid = win_getid()
        timer_start(duration, (_) => {
            # keymap like `:vmap // y/<C-R>"<CR>` (search for visually selected text) throws E803
            try
                m->matchdelete(winid)
            catch
            endtry
        })
    endif
enddef

export def HighlightOnYankLegacy(hlgroup = 'IncSearch', duration = 300, in_visual = true)
    if v:event.operator ==? 'y'
        if !in_visual && visualmode() != null_string
            visualmode(1)
            return
        endif
        var [lnum_beg, col_beg, off_beg] = getpos("'[")[1 : 3]
        var [lnum_end, col_end, off_end] = getpos("']")[1 : 3]
        col_end += !v:event.inclusive ? 1 : 0
        var maxcol = v:maxcol - 1
        var visualblock = v:event.regtype[0] ==# "\<C-V>"
        var pos = []
        for lnum in range(lnum_beg, lnum_end, lnum_beg < lnum_end ? 1 : -1)
            var col_b = (lnum == lnum_beg || visualblock) ? (col_beg + off_beg) : 1
            var col_e = (lnum == lnum_end || visualblock) ? (col_end + off_end) : maxcol
            pos->add([lnum, col_b, min([col_e - col_b + 1, maxcol])])
        endfor
        var m = matchaddpos(hlgroup, pos)
        var winid = win_getid()
        timer_start(duration, (_) => {
            try
                m->matchdelete(winid)
            catch
            endtry
        })
    endif
enddef
