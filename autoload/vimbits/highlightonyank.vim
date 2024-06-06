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
        timer_start(duration, (_) => m->matchdelete(winid))
    endif
enddef
