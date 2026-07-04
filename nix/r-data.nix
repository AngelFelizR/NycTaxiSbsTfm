let
  pkgs = import ./pkgs.nix;
in
  builtins.attrValues {
    inherit (pkgs.rPackages)
      data_table fst qs2 DBI duckdb rvest tidytext
      stringdist fuzzyjoin igraph DiagrammeR future
      future_apply corrr hashr timeDate;
  }
