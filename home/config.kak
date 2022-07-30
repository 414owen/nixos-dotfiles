eval %sh{kak-lsp --kakoune -s $kak_session}

set-option global lsp_server_configuration haskellLanguageServer.hlintOn=true
set-option global lsp_server_configuration haskellLanguageServer.formattingProvider=brittany

hook global WinSetOption filetype=(haskell|rust|c|cpp|d|idris) %{
  lsp-enable-window
  lsp-auto-hover-enable
  map global normal <c-l> ':enter-user-mode lsp<ret>'
  map global lsp t ':lsp-type-definition<ret>'
}

hook global WinCreate .* %{
  kakboard-enable
  require-module quickscope
  set-option global quickscope_user_mode '.*' # '.^' to disable (default)
  map global normal <f> ': quickscope-f<ret>'
  map global normal <a-f> ': quickscope-a-f<ret>'
  map global normal <t> ': quickscope-t<ret>'
  map global normal <a-t> ': quickscope-a-t<ret>'
  map global normal <F> ': quickscope-F<ret>'
  map global normal <a-F> ': quickscope-a-F<ret>'
  map global normal <T> ': quickscope-T<ret>'
  map global normal <a-T> ': quickscope-a-T<ret>'
}

hook global BufCreate .+\.idr %{ set buffer filetype idris }

hook global WinCreate ^[^*]+$ %{ editorconfig-load }

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

colorscheme default # your colorscheme
set-face global EasyMotionForeground rgb:fdf6e3,rgb:268bd2+fg
add-highlighter global/trailing-whitespace regex '\h+$' 0:Error

declare-option str gray 'rgb:44475a'
face global MenuBackground gray
face global MenuForeground gray
set-face global PrimarySelection black,white
set-face global PrimaryCursor black,red
set-face global SecondarySelection white,black
set-face global SecondaryCursor black,blue
