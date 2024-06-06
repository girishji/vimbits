#!/bin/bash

# put vim in ex mode so that error messages appear in stderr/stdout. otherwise
# vim clears stdout/stderr on exit. use `verbose` to direct messages to stderr.
# syntax errors can make the test hang.

for test_file in highlight.vim yank.vim visual.vim; do
    vim -nEs -u DEFAULTS -i NONE -S <(cat <<EOF
        vim9script
        set shortmess=I
        so ../plugin/fFtT.vim
        so ./${test_file}
        qa!
    EOF
    )
done
