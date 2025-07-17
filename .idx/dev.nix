{ pkgs, ... }: {
  channel = "stable-25.05";
  packages = with pkgs; [
    zsh
    git
    curl
  ];
  env = { };
  idx = {
    extensions = [
    ];
    previews = {
      enable = true;
      previews = { };
    };
    workspace = {
      onCreate = {
        ohmyzsh-install = ''
          echo [onCreate] Instalando o OhMyZsh...

          export RUNZSH=no
          export CHSH=no

          OHMYZSH="$HOME/.oh-my-zsh"

          if [ ! -d "$OHMYZSH" ]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

            echo "Alterando tema para 'jonathan'..."
            sed -i 's/ZSH_THEME=".*"/ZSH_THEME="jonathan"/' ~/.zshrc

            echo "Inserindo ZSH_DISABLE_COMPFIX=true..."
            sed -i '/^source \$ZSH\/oh-my-zsh.sh/i ZSH_DISABLE_COMPFIX=true' ~/.zshrc
          else
            echo "OhMyZsh já está instalado."
          fi
        '';
      };
      onStart = {
        zsh-init = ''
          echo "[onStart] Iniciando o ZSH..."

          if ! grep -q "exec zsh" ~/.bashrc; then
            echo "[onStart] Adicionado 'exec zsh' ao ~/.bashrc"
            printf "\nexec zsh\n" >> ~/.bashrc
          else
            echo "[onStart] 'exec zsh' já presente no ~/.bashrc"
          fi
        '';
        };
    };
  };
}
