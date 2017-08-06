__ct=clearcase
alias ct=$__ct
alias sv="$__ct sv"
alias rmpriv='ct lspriv | grep -v "^/bce" | grep -v "/tags$" | grep -v "\[checkedout\]" | xargs rm -r'
