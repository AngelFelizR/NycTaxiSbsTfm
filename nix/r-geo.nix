let
  pkgs = import ./pkgs.nix;
in
  builtins.attrValues {
    inherit (pkgs.rPackages)
      sf tmap maptiles osmdata leaflet tidycensus units;
  }
