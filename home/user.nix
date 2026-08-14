{
  username,
  pkgs,
  zenBrowser,
  matuPkg,
  ...
}:
{
  imports = [ ./corefonts.nix ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # Browsers
    firefox
    zenBrowser
    chromium

    # Terminal
    kitty
    fzf
    btop
    fastfetch
    oh-my-posh

    # Dev
    neovim
    tree-sitter
    nixd
    nixfmt
    ripgrep
    lazygit
    claude-code
    uv

    # Desktop / Wayland
    awww
    quickshell
    brightnessctl
    matugen
    nwg-displays

    #Archives
    file-roller
    p7zip
    unzip
    zip
    unrar
    gzip
    bzip2
    xz
    zstd

    # Apps
    telegram-desktop
    pavucontrol
    nautilus
    qalculate-qt
    onlyoffice-desktopeditors
    kdePackages.kdeconnect-kde

    # Theming
    nwg-look
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    glib
    gsettings-desktop-schemas
    (colloid-gtk-theme.override {
      colorVariants = [
        "dark"
        "light"
      ];
    })
    colloid-icon-theme
    bibata-cursors

    # Utils
    stow
    imagemagick
    jq
    matuPkg

    # Fonts
    roboto
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}
