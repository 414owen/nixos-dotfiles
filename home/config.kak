eval %sh{kak-lsp --kakoune -s $kak_session}
# set global lsp_cmd "~/src/kak-lsp/target/debug/kak-lsp -s %val{session} -vvv --log /home/owen/kak-lsp.log"
# eval %sh{kak-lsp --kakoune -s $kak_session}
 
set-option global lsp_server_configuration haskellLanguageServer.hlintOn=true

hook global WinSetOption filetype=(haskell|ruby|rust|javascript|terraform|c|cpp) %{
  lsp-enable-window
  lsp-auto-hover-enable
  map global normal <c-l> ':enter-user-mode lsp<ret>'
  map global lsp t ':lsp-type-definition<ret>'
}

hook global WinCreate .* %{ kakboard-enable }

hook global InsertChar j %{ try %{
  exec -draft hH <a-k>kj<ret> d
  exec <esc>
}}

hook global KakBegin .* %{
  evaluate-commands %sh{
    path="$PWD"
    while [ "$path" != "$HOME" ] && [ "$path" != "/" ]; do
      if [ -e "./tags" ]; then
        printf "%s\n" "set-option -add current ctagsfiles %{$path/tags}"
        break
      else
        cd ..
        path="$PWD"
      fi
    done
  }
}
