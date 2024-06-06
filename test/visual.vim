vim9script

so ./setup.vim

# Lorem ipsum doloćrż sit amęt, cąnsęctetuer adipiscing elit.

cursor(1, 24)
norm vfc"ay
'a'->getreg()
if assert_notequal('it amęt, c', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

cursor(1, 24)
norm vtn"ay
'a'->getreg()
if assert_notequal('it amęt, cą', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

cursor(1, 24)
norm vTp"ay
if assert_notequal('sum doloćrż si', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

cursor(1, 24)
norm vFi"ay
if assert_notequal('ipsum doloćrż si', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

qa!
