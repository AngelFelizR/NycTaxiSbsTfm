let
  pkgs = import ./pkgs.nix;
in
  builtins.attrValues {
    inherit (pkgs.rPackages)
      tibble stringr glue lubridate patchwork scales
      tidymodels recipes infer car knitr rmarkdown
      ggplot2 ggtext ggiraph plotly gt here withr
      tictoc testthat devtools;
  }
