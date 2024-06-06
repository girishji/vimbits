vim9script

so ./setup.vim

# Lorem ipsum doloćrż sit amęt, cąnsęctetuer adipiscing elit.

cursor(1, 24)
norm "ayfc
'a'->getreg()
if assert_notequal('it amęt, c', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

cursor(1, 24)
norm "aytn
'a'->getreg()
if assert_notequal('it amęt, cą', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

cursor(1, 24)
norm "ayTp
if assert_notequal('sum doloćrż s', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

cursor(1, 24)
norm "ayFi
if assert_notequal('ipsum doloćrż s', 'a'->getreg()) == 0
    verbose echoerr v:errors
endif

qa!
