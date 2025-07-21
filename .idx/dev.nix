{ pkgs, ... }: {
  channel = "stable-25.05";
  packages = with pkgs; [
    zsh
    git
    curl
    zip
  ];
  env = { };
  idx = {
    extensions = [
      "redhat.java"
      "vmware.vscode-boot-dev-pack"
      "vmware.vscode-spring-boot"
      "vscjava.vscode-gradle"
      "vscjava.vscode-java-debug"
      "vscjava.vscode-java-dependency"
      "vscjava.vscode-java-pack"
      "vscjava.vscode-java-test"
      "vscjava.vscode-maven"
      "vscjava.vscode-spring-boot-dashboard"
      "vscjava.vscode-spring-initializr"
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
        sdkman-install = ''
          echo "🔧 Verificando SDKMAN..."

          export SDKMAN_DIR="$HOME/.sdkman"

          if [ ! -d "$SDKMAN_DIR" ]; then
            echo "📦 Instalando SDKMAN..."
            curl -s "https://get.sdkman.io" | bash
          else
            echo "✅ SDKMAN já instalado."
          fi

          if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
            source "$SDKMAN_DIR/bin/sdkman-init.sh"
            echo "🚀 SDKMAN carregado!"
          else
            echo "⚠️ Não foi possível carregar o SDKMAN."
          fi

          if command -v sdk >/dev/null 2>&1; then
            sdk install java 21.0.8-zulu
          else
            echo "⚠️ Comando 'sdk' não disponível."
          fi

          zsh
        '';
      };
    };
  };
}
