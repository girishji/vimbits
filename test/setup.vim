vim9script

enew
setl buftype=nofile noswapfile nonu nornu
var line = 'Lorem ipsum doloćrż sit amęt, cąnsęctetuer adipiscing elit.'
line->setline(1)
if assert_equal(line, getline(1)) == 1
    verbose echoerr v:errors
endif
if assert_equal([], getmatches()) == 1
    verbose echoerr v:errors
endif

