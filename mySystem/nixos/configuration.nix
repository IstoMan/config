# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  #Enable Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true; 

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable MPD service 
  services.mpd.enable = true;

  # Enble Auto-cpufreq
  services.auto-cpufreq.enable = true;

  # Enable JellyFin server
  services.jellyfin.enable = true;

  # Set Zsh as default shell
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
  # Enable Autojump
  programs.autojump.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.suhas = {
    isNormalUser = true;
    description = "Suhas";
    extraGroups = ["mpd" "kvm" "networkmanager" "wheel" "libvirtd" "jellyfin"];
    packages = with pkgs; [
      librewolf
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flathub
  services.flatpak.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim 
    wget
    curl
    git 
    gcc
    # gnome.gnome-tweaks
    neofetch
    nodejs
    unzip
    dunst
    libnotify
    kitty
    virt-manager
    fd
    fzf
    ripgrep
    cargo
    wl-clipboard
    xclip
    home-manager
    bat
    lf 
    tor-browser-bundle-bin
    ctpv
    github-desktop
    transmission-gtk
    tauon
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.appindicator
    # gnomeExtensions.gsconnect
    # gnomeExtensions.gesture-improvements
    # gnomeExtensions.clipboard-indicator
    mpd
    mpc-cli
    ncmpcpp
    borgbackup
    trash-cli
    exiftool
    atool
    ffmpegthumbnailer
    ffmpeg
    diff-so-fancy
    gnupg
    lynx
    chafa
    jq
    poppler_utils
    imagemagick
    highlight
    sourceHighlight
    glow
    tagger
    auto-cpufreq
    eza
    vscodium
    jellyfin-media-player
    kodi-wayland
    btop
  ];

  # Enable Automatic systemc updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";

 # Configure fonts 
  fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        source-han-sans
        inter
        source-han-sans-japanese
        source-han-serif-japanese
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "JetBrains Mono Regular Nerd Font Complete Mono" ];
          serif = [ "Inter" "Noto Serif" ];
          sansSerif = [ "Inter" "Noto Sans" ];
        };
      };
      fontDir.enable = true;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
