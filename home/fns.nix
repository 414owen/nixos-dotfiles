{ pkgs }:

let tee = "${pkgs.coreutils}/bin/tee";
    jq = "${pkgs.jq}/bin/jq";
    less = "${pkgs.less}/bin/less";
    common = import ./common.nix;
in

''
SEVENZ="${pkgs.p7zip}/bin/7z"
CURL="${pkgs.curlFull}/bin/curl"
JSON="${jq}"
LESSCMD="${less}"

add-rpaths() {
  if [ $# -eq 0 ]; then
    echo "Usage: add-rpaths elf-path rpath..."
  fi
  pe=${pkgs.patchelf}/bin/patchelf
  $pe --print-rpath $1
  rpath=$($pe --print-rpath $1)
  shift
  for path in $@; do
    $pe --set-rpath $path:$rpath
  done
}

withdir() {
  d="$(basename "$1" "$2")"
  mkdir "$d"
  pushd "$d"
  eval $3 "'../$1'"
  popd
}

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.7z)        $SEVENZ x $1    ;;
      *.Z)         uncompress $1   ;;
      *.bz2)       bunzip2 $1      ;;
      *.gz)        gunzip $1       ;;
      *.lzma)      xz --decompress ;;
      *.rar)       $SEVENZ x $1      ;;
      *.tar)       $TAR xvf $1      ;;
      *.tar.bz2)   $TAR xvjf $1     ;;
      *.tar.gz)    $TAR xvzf $1     ;;
      *.tbz2)      $TAR xvjf $1     ;;
      *.tgz)       $TAR xvzf $1     ;;
      *.xz)        $BUSYBOX/xz --decompress ;;
      *.zip)       $BUSYBOX/unzip $1        ;;
      *)           echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

maketar() { $TAR cvzf "$\{1%%/}.tar.gz"  "$\{1%%/}/"; }

makezip() { ${pkgs.zip}/bin/zip -r "$\{1%%/}.zip" "$1" ; }

short() {
  $CURL -F"shorten=$*" https://0x0.st
}

mkcd() {
  mkdir -p $1
  cd $1
}

teehist() {
  print -rs $1
  eval $1
}

firstArg() {
  for i in $@; do
    if [ ! -z "$i" ]; then
      echo "$i"
      break
    fi
  done
}

gsu() {
  local branch="$(git rev-parse --abbrev-ref HEAD)"
  git branch "--set-upstream-to=$(firstArg "$1" origin)/$(firstArg "$2" $branch)" "$branch"
}

trim() {
  echo $1 | xargs
}

rgb() {
  rg "\b$@\b"
}

tee() {
  if [[ -t 1 ]]; then
    ${tee} $@ | $JSON -Rr 'try fromjson // .'
  else
    ${tee} $@
  fi
}

less() {
  if [[ -t 1 ]]; then
    $JSON -CRr 'try fromjson // .' | $LESSCMD -R $@
  else
    $LESSCMD -R $@
  fi
}

try() {
  if [ -z "$2" ]; then
    2="$1"
  fi
  nix-shell -p "$1" --run "$2"
}

function cd() {
  if [ "$#" = "0" ]; then
    pushd "$HOME" > /dev/null
  elif [ -f "$1" ]; then
    builtin cd "$(dirname "$1")"
  else
    pushd "$1" > /dev/null
  fi
}

function bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq "$1")
    do
      popd > /dev/null
    done
  fi
}

function yt() {
  url="$1"
  open -a"quicktime player" "$(yt-dlp -g -f '(mkv,mp4)[height<=720]' "$url")"
}
''
