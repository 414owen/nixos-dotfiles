let
  lib = (import <nixpkgs> {}).lib;
  strhead = builtins.substring 0 1;
  tosed = str: " -e 's/ ${str}s\\? ago)/${strhead str})/' -e 's/ ${str}s\\?, /${strhead str}, /'";
  sedexprs = lib.concatMapStrings tosed ["second" "minute" "hour" "day" "week" "month" "year"];
  mkgraph = extra: "git lg --color=always ${extra} | gitlogprettify | less";
  mkgraphall = extra: mkgraph "--all ${extra}";
in with (import ./defaults.nix); builtins.foldl' (a: b: a // b) {} ([{
  cat = cat;
  c  =  "clear";
  "....." = "cd ../../../../";
  "...." = "cd ../../../../";
  "..." = "cd ../../../";
  ".." = "cd ..";
  copy = "xsel -b";
  cs = "clear;ls";
  debug = "set -o nounset; set -o xtrace";
  e = editor;
  ef = "file=$(${fuzzy}); [ ! -z \"$file\" ] && echo \"$file\" && teehist \"e $file\"";
  ff = fuzzy;
  f = find;
  find = find;
  gaaa = "git add --all";
  gaa = "git add .";
  ga = "git add";
  gau = "git add --update";
  gbd = "git branch --delete";
  gb = "git branch";
  gc = "git commit";
  gca = "git commit --amend";
  gcf = "git commit --fixup";
  gcl = "git clone";
  gcm = "git commit --message";
  gcne = "git commit --no-edit";
  gcob = "git checkout -b";
  gcod = "git checkout develop";
  gco = "git checkout";
  gcom = "git checkout master";
  gcos = "git checkout staging";
  gda = "git diff HEAD";
  gdc = "git diff --cached";
  gd = "git diff";
  gerp = grep;
  gg = mkgraph "";
  gga = mkgraph "--all";
  ggp = mkgraph "-p --simplify-by-decoration";
  ggpa = "ggp --all";
  ghs = grep + " -g '*.hs'";
  gi = "git init";
  gitlogprettify = "sed ${sedexprs}";
  gld = "git log --pretty = format:\"%h %ad %s\" --date = short --all";
  gma = "git merge --abort";
  gmc = "git merge --continue";
  gm = "git merge --no-ff";
  gp = "git pull";
  gpr = "git pull --rebase";
  grep = grep;
  gr = "git rebase";
  gra = "git rebase --abort";
  grc = "git rebase --continue";
  gs = "git status";
  gss = "git status --short";
  gsta = "git stash apply";
  gstd = "git stash drop";
  gst = "git stash";
  gstl = "git stash list";
  gstp = "git stash pop";
  gsts = "git stash save";
  h = "history";
  hb = "hadrian/build -j$(($(ncpus) +1))";
  hbq = "hb --flavour=quick";
  hbqs = "hbq --skip='//*.mk' --skip='stage1:lib:rts'";
  hbqf = "hbqs --freeze1";
  hbv = "hb --flavour=validate --build-root=_validate";
  hbvs = "hbv --skip='//*.mk' --skip='stage1:lib:rts'";
  hbvf = "hbvs --freeze1";
  hbt = "mkdir -p _ticky; [ -e _ticky/hadrian.settings ] || echo 'stage1.*.ghc.hs.opts += -ticky\\nstage1.ghc-bin.ghc.link.o
pts += -ticky' > _ticky/hadrian.settings; hb --flavour=validate --build-root=_ticky";
  hbts = "hbt --skip='//*.mk' --skip='stage1:lib:rts'";
  hbtf = "hbts --freeze1";
  hs = "nix-build -E '(import <nixpkgs> {}).haskellPackages.callCabal2nix \"\" ./. {}'";
  hsd = "nix-shell -E '(import <nixpkgs> {}).haskellPackages.developPackage {root = ./.;}'";
  k = "kill";
  less = "less -R";
  ll = ls + " -alF";
  l = ls + " -lah";
  lsl = ls + " -lah";
  ls = ls;
  mkdir = "mkdir -p";
  "null" = "/dev/null";
  o = "xdg-open";
  p = cat;
  pd = "pwd";
  r = "ranger";
  reload = "source $DOTFILE";
  sl = ls;
  sudo = "sudo ";
  t = "time";
  tmuxrec = "mkdir -p ~/casts; asciinema rec ~/casts/$(date +'%m-%d-%Y-%H:%M.cast') -c tmux";
}] ++ map (i: {
  "gd${i}" = "git diff HEAD~${i}";
  "gr${i}" = "git rebase --interactive HEAD~${i}";
}) (map toString (lib.range 1 9)))
