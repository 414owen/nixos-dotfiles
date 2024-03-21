{pkgs}:
let
  lib = pkgs.lib;
  mylib = import ./lib.nix { inherit lib; };
  strhead = builtins.substring 0 1;
  tosed = str: " -e 's/ ${str}s\\? ago)/${strhead str})/' -e 's/ ${str}s\\?, /${strhead str}, /'";
  sedexprs = lib.concatMapStrings tosed ["second" "minute" "hour" "day" "week" "month" "year"];
  mkgraph = extra: "git lg --color=always ${extra} | gitlogprettify | less";
  mkgraphall = extra: mkgraph "--all ${extra}";
  histIgnore = ["ls" "mv" "cp" "reboot" "poweroff"];
in with (import ./defaults.nix); builtins.foldl' (a: b: a // b) {} ([
(builtins.listToAttrs (map (cmd: {name = cmd; value = " ${cmd}";}) histIgnore))
{
  awssh = "ssh -i ~/.ssh/aws-prod-keypair.pem -l root";
  cat = cat;
  c  =  "clear";
  cf = "cd \"$(fd -t d | fzf)\"";
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
  gcmnv = "git commit --message --no-verify";
  gcnenv = "git commit --no-edit --no-verify";
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
  gitlogprettify = "sed ${sedexprs}";
  gld = "git log --pretty = format:\"%h %ad %s\" --date = short --all";
  gma = "git merge --abort";
  gmc = "git merge --continue";
  gm = "git merge --no-ff";
  gp = "git pull";
  gpr = "git pull --rebase";
  gpu = "git push";
  gpuu = "git push -u $(git remote)";
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
  hb = "hadrian/build -j";
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
  hsdl = "nix-shell -E 'let pkgs = import <nixpkgs> {}; in pkgs.haskellPackages.developPackage {root = ./.; modifier = drv: pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages; [ haskell-language-server ]);}'";
  json = "jq -Rr 'try fromjson // .'";
  k = "kill";
  kubs = "kubectl -n backend-staging";
  kubp = "kubectl -n backend-production";
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
  tree = "eza --tree";
  t = "time";
}] ++ (map (i: let a = toString i; in {
  "gd${a}" = "git diff HEAD~${a}";
  "gr${a}" = "git rebase --interactive HEAD~${a}";
  ".${mylib.repeatStr "." i}" = "cd ${mylib.repeatStr "../" i}";
}) (lib.range 1 9))
  ++ (if pkgs.stdenv.isDarwin
  then [{
    nproc = "sysctl -n hw.logicalcpu";
  }]
  else [])
)
