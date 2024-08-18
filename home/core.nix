{ pkgs, ... }:

{
  home.packages = with pkgs; [
    
    ## Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })  
    
    ## CLI Tools 
    _1password
    cowsay
    curl
    file
    fortune
    fzf # A command-line fuzzy finder
    gawk
    gnupg
    gnused
    gnutar
    htop
    jq # A lightweight and flexible command-line JSON processor
    lazygit
    lsof # list open files
    mc
    nnn # terminal file manager
    ripgrep # recursively searches directories for a regex pattern
    stow
    tmux
    tokei
    tree
    util-linux # for uuidgen
    wget
    which
    ### archives
    p7zip
    unzip
    xz
    zip
    ### devops
    docker
    docker-compose
    kubectl
    nmap # A utility for network discovery and security auditing
    terraform
    ### dev environments
    nodejs
    yarn
    ### multimedia
    ffmpeg
    yt-dlp
    ### cloud platforms
    awscli2
    azure-cli
    doctl
    google-cloud-sdk
    
  ];

  home.file = {
    ".config/nvim".source = ~/dotfiles/nvim;
    ".tmux.conf".source = ~/dotfiles/tmux/.tmux.conf;
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      alias hist="history 1"
      alias p2="cd ~/Nextcloud/obsidian/player2; nvim todo.md"
      alias dtf="cd ~/dotfiles; nvim"
      alias ll='ls -lh'
      alias la='ls -A'
      alias l='ls -CF'
      alias nano="nvim"
    '';
    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "z" "sudo" "kubectl" ];
    };
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      alias k="kubectl"
      alias hist="history 1"
      alias p2="cd ~/Nextcloud/obsidian/player2; nvim todo.md"
      alias dtf="cd ~/dotfiles; nvim"
      alias ll='ls -lh'
      alias la='ls -A'
      alias l='ls -CF'
      alias nano="nvim"
    '';
  };

  # Github CLI configuration
  programs.gh = {
    enable = true;
  };

  # modern vim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      font.normal = { 
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      font.size = 16;
      env.TERM = "xterm-256color";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window.padding = { 
        x = 24;
        y = 24; 
      };
      window.decorations = "Full";
      window.opacity = 0.8;
    };
  };

}
