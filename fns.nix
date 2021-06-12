{ pkgs }:

let tee = "${pkgs.coreutils}/bin/tee";
    jq = "${pkgs.jq}/bin/jq";
    less = "${pkgs.less}/bin/less";
in

''
BUSYBOX="${pkgs.busybox}/bin"
TAR=$BUSYBOX/tar
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

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.7z)        $SEVENZ x $1         ;;
      *.Z)         ${pkgs.gzip}/bin/uncompress $1   ;;
      *.bz2)       $BUSYBOX/bunzip2 $1      ;;
      *.gz)        $BUSYBOX/gunzip $1       ;;
      *.lzma)      $BUSYBOX/xz --decompress ;;
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
  if [ "$#" = "0" ]
  then
  pushd "$HOME" > /dev/null
  elif [ -f "$1" ]
  then
    "$EDITOR" "$1"
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

function scratch-sil {
    if [ -v BASH_SOURCE ]; then
        # Make all setting changes local to this function, bash version
        local -
        local THIS=''${BASH_SOURCE[0]}
    elif [ -v ZSH_VERSION ]; then
        # Make all setting changes local to this function, zsh version
        set -o localoptions
        local THIS=''${(%):-%x}
    else
        echo "Unsupported shell, run under bash or zsh." >&2
        return 1
    fi

    git clean -dfx

    if command -v pacman &> /dev/null; then
        sudo kalcore/extern_deps/provision-arch.sh
    elif command -v apt &> /dev/null; then
        sudo kalcore/extern_deps/provision-apt.sh
    else
        echo "Unsupported distro"
        return 1
    fi

    kalcore/extern_deps/build_and_cache_libs.sh
    source ./setup_ci_env.sh
    (cd tools/registry-login && dub)
    ./mkrepl.sh
}
''
