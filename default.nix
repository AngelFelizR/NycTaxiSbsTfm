let
  # 1. Cargamos el pin unificado del proyecto
  pkgs = import ./nix/pkgs.nix;

  # 2. Importamos los entornos de sistema y LaTeX
  systemPackages = import ./nix/system.nix;
  latexPackages  = import ./nix/latex.nix;

  # 3. Importamos tus listas de paquetes de R modulares
  rCorePkgs   = import ./nix/r-core.nix;
  rCustomPkgs = import ./nix/r-custom.nix;
  rDataPkgs   = import ./nix/r-data.nix;
  rGeoPkgs    = import ./nix/r-geo.nix;

  # 4. Generamos la envoltura oficial de R inyectando de forma plana todos tus paquetes
  rEnv = pkgs.rWrapper.override {
    packages = rCorePkgs ++ rCustomPkgs ++ rDataPkgs ++ rGeoPkgs;
  };

  # 5. Configuración del Shell de desarrollo
  shell = pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    # Configuración de fuentes para ggplot2 / ggtext / Quarto PDFs
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    FONTCONFIG_PATH = "${pkgs.fontconfig.out}/etc/fonts/";

    shellHook = ''
      export XDG_DATA_DIRS="${pkgs.dejavu_fonts}/share:${pkgs.freefont_ttf}/share:$XDG_DATA_DIRS"
      fc-cache -f 2>/dev/null || true
    '';

    # Consolidación de todas las capas en el Shell
    buildInputs = [
      rEnv
      systemPackages
      latexPackages
    ];
  };
in
{
  inherit pkgs shell;
}
