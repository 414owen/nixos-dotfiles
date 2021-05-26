{ lib, ... }:

rec {
  repeat = el: n: builtins.map (i: el) (lib.range 1 n);
  repeatStr = str: n: lib.concatStrings (repeat str n);
}
