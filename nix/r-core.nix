let
  pkgs = import ./pkgs.nix;
in
  builtins.attrValues {
    inherit (pkgs.rPackages)
      tibble stringr glue lubridate patchwork scales
      tidymodels xgboost recipes infer car knitr rmarkdown webshot2
      ggplot2 ggtext gt here withr;
  }
