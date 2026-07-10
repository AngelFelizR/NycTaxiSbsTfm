let
  pkgs = import ./pkgs.nix;
in
  builtins.attrValues {
    inherit (pkgs.rPackages)
      tibble stringr glue lubridate knitr rmarkdown
      tidymodels xgboost recipes infer car sysfonts showtext
      ggplot2 ggtext ggrepel scales here withr;
  }
