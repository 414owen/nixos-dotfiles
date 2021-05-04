eval %sh{kak-lsp --kakoune -s $kak_session}

set-option global lsp_server_configuration haskellLanguageServer.hlintOn=true
set-option global lsp_server_configuration haskellLanguageServer.formattingProvider=brittany

hook global WinSetOption filetype=(haskell|rust|c|cpp) %{
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

set-face global search +bi
add-highlighter global/search dynregex '%reg{/}' 0:search
add-highlighter global/ column '%opt{autowrap_column}' default,red
add-highlighter global/trailing-whitespace regex '\h+$' 0:Error

declare-option str gray 'rgb:44475a'
face global MenuBackground gray
face global MenuForeground gray
set-face global PrimarySelection black,white
set-face global PrimaryCursor black,red
set-face global SecondarySelection white,black
set-face global SecondaryCursor black,blue
