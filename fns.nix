{ pkgs }:

let tee = "${pkgs.coreutils}/bin/tee";
    less = "${pkgs.less}/bin/less";
in

''
BUSYBOX=${pkgs.busybox}/bin
TAR=$BUSYBOX/tar
SEVENZ="${pkgs.p7zip}/bin/7z"
CURL=${pkgs.curlFull}/bin/curl

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

gpu() {
  local upstream="$1"
  shift
  git push --set-upstream $(firstArg "$upstream" "origin") $@
}

gph() {
  gpu $(firstArg "$1" "origin") HEAD
}

trim() {
  echo $1 | xargs
}

tee() {
  if [[ -t 1 ]]; then
    command ${tee} $@ | jq -Rr 'try fromjson // .'
  else
    command ${tee} $@
  fi
}

less() {
  if [[ -t 1 ]]; then
    jq -CRr 'try fromjson // .' | command ${less} -R $@
  else
    command ${less} -R $@
  fi
}
''
