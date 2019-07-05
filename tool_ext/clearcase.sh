if type cleartool >/dev/null 2>/dev/null; then
        __ct=cleartool
        alias ct=$__ct
        alias sv="$__ct setview -login"
        alias rmpriv='ct lspriv | grep -v "^/bce" | grep -v "/tags$" | grep -v "\[checkedout\]" | xargs rm -r'
    else
      :
        #__import_log "* Clearcase Not found. If desired, add cleartool to your path and resource init.sh"
fi

