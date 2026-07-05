let
  pkgs = import ./pkgs.nix;
in
  builtins.attrValues {
    inherit (pkgs.rPackages)
      data_table fst qs2 igraph DiagrammeR timeDate;
  }
