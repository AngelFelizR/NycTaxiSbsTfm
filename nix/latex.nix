let
  pkgs = import ./pkgs.nix;
in
  pkgs.buildEnv {
    name = "latex-packages";
    paths = [
      (pkgs.texlive.combine {
        inherit (pkgs.texlive) 
          scheme-small
          scheme-medium
          collection-fontsextra
          csquotes
          fancyhdr
          fontawesome5
          fontspec
          makecell
          orcidlink
          pdfcol
          pdflscape
          tcolorbox
          threeparttable
          threeparttablex
          tikzfill
          titling;
      })
    ];
  }
