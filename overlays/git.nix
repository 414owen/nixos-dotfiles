final: prev: rec {
  git = prev.git.override {
    withManual = false;
    pythonSupport = false;
    perlSupport = false;
    nlsSupport = false;
    withpcre2 = false;
    sendEmailSupport = false;
    withLibsecret = false;
    withSsh = false;
  };
  gitMinimal = git;
}
