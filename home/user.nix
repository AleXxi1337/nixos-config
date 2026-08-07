{ username, pkgs, lib, zenBrowser, ... }:
let
  hymission = pkgs.hyprlandPlugins.mkHyprlandPlugin {
    pluginName = "hymission";
    version    = "master";
    src = pkgs.fetchzip {
      url    = "https://github.com/gfhdhytghd/hymission/archive/refs/heads/master.tar.gz";
      sha256 = "1vh01bgpijlq96jjlb631jq6v2cd3mjl0cbic3sqlid8qwikilah";
    };
    nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config ];
    buildInputs       = [ pkgs.nlohmann_json pkgs.expat ];
    cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
    meta = {};
  };
in
{
  imports = [];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  home.activation.copyOnlyOfficeFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/share/fonts/corefonts
    cp -f --remove-destination ${pkgs.corefonts}/share/fonts/truetype/*.ttf $HOME/.local/share/fonts/corefonts/
    chmod 644 $HOME/.local/share/fonts/corefonts/*.ttf
  '';

  home.packages = with pkgs; [
    kitty
    firefox
    zenBrowser
    claude-code
    stow
    neovim
    tree-sitter
    nixd
    brightnessctl
    awww
    hyprlandPlugins.hyprbars
    hymission
    matugen
    oh-my-posh
    fastfetch
    fzf
    telegram-desktop
    pavucontrol
    chromium
    imagemagick
    jq
    btop
    quickshell
    nautilus
    nwg-look
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    kdePackages.kdeconnect-kde
    qalculate-qt
    onlyoffice-desktopeditors
    glib
    gsettings-desktop-schemas
    (colloid-gtk-theme.override {
      colorVariants = [ "dark" "light" ];
    })
    colloid-icon-theme
    bibata-cursors

    # Fonts
    roboto
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}
