vim9script

so ./setup.vim

def Verify(cmd: string, not_hi: list<number>)
    exe $'normal {cmd}'
    if assert_notequal([], getmatches()) == 1
        verbose echoerr v:errors
    endif
    for v in getmatches()[0]->values()
        if v->type() == v:t_list && v->len() == 3
            if  v[0] != 1 || not_hi->index(v[1]) != -1
                verbose echoerr 'error at' v
            endif
        endif
    endfor
enddef

# Lorem ipsum doloćrż sit amęt, cąnsęctetuer adipiscing elit.

cursor(1, 1)
var nhi = range(1, 10)->extend([13, 15, 17, 20, 25, 27, 29, 32, 34, 37, 58, 64])
Verify('f', nhi)
if assert_notequal([], getmatches()) == 1
    verbose echoerr v:errors
endif
exe "normal \<esc>"
if assert_equal([], getmatches()) == 1
    verbose echoerr v:errors
endif

cursor(1, 1)
nhi = [16, 28, 38, 42, 46, 47, 51, 55]
Verify('3f', nhi)
normal "\<esc>"

cursor(1, 19)
nhi = range(1, 19)
Verify('f', nhi)
normal "\<esc>"

cursor(1, 24)
nhi = range(15, 64)->extend([1, 4, 7, 8, 10, 11, 13])
Verify('F', nhi)
normal "\<esc>"

cursor(1, 24)
nhi = range(24, 64)
Verify('4F', nhi)
normal "\<esc>"

cursor(1, 24)
nhi = range(24, 64)->extend([2])
Verify('3F', nhi)
normal "\<esc>"

cursor(1, 24)
nhi = range(1, 30)->extend([32, 34, 35, 36, 37, 38, 43, 45, 47, 50, 51, 52, 58, 64])
Verify('t', nhi)

cursor(1, 24)
nhi = range(1, 24)->extend([42, 55, 56, 60])
Verify('3t', nhi)

cursor(1, 24)
nhi = range(15, 64)->extend([1, 4, 7, 8, 10, 11, 13])
Verify('T', nhi)
if assert_notequal([], getmatches()) == 1
    verbose echoerr v:errors
endif
exe "normal \<esc>"
if assert_equal([], getmatches()) == 1
    verbose echoerr v:errors
endif

cursor(1, 24)
nhi = range(24, 64)->extend([2])
Verify('3T', nhi)

qa!
