let
  # Pin unificado
  pkgs = import ./nix/pkgs.nix;

  # Entornos de sistema
  systemPackages = import ./nix/system.nix;
  latexPackages  = import ./nix/latex.nix;

  # Paquetes de R (listas de derivaciones)
  rCorePkgs   = import ./nix/r-core.nix;
  rCustomPkgs = import ./nix/r-custom.nix;
  rDataPkgs   = import ./nix/r-data.nix;
  rGeoPkgs    = import ./nix/r-geo.nix;

  shell = pkgs.mkShell {
    LOCALE_ARCHIVE =
      if pkgs.stdenv.hostPlatform.system == "x86_64-linux"
      then "${pkgs.glibcLocales}/lib/locale/locale-archive"
      else "";

    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    FONTCONFIG_PATH = "${pkgs.fontconfig.out}/etc/fonts/";

    shellHook = ''
      export XDG_DATA_DIRS="${pkgs.dejavu_fonts}/share:${pkgs.freefont_ttf}/share:$XDG_DATA_DIRS"
      fc-cache -f 2>/dev/null || true
    '';

    buildInputs =
      [
        pkgs.R
        systemPackages
        latexPackages
      ]
      ++ rCorePkgs
      ++ rCustomPkgs
      ++ rDataPkgs
      ++ rGeoPkgs;
  };

in
{
  inherit pkgs shell;
}
