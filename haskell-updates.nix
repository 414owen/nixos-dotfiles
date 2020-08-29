{ lib, ... }:
(import (builtins.fetchGit (lib.importJSON ./haskell-updates.json)) {})
