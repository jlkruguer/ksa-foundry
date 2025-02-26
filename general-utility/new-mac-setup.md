# MacBook Air M3 Setup 

Focus on ML/AI Development. Specific install for basic conda environments with considerations for Apple Silicon. 


## Table of Contents
- [Development Environment](#development-environment)
- [Conda Environment Setup](#conda-environment-setup)
- [IDE and Text Editors](#ide-and-text-editors)
- [Cross-Platform Development Tools](#cross-platform-development-tools)
- [Productivity Tools](#productivity-tools)
- [Final Optimizations](#final-optimizations)


## Development Environment

### Install Command Line Tools
```bash
xcode-select --install
```

### Install Homebrew (Package Manager)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to your PATH:
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

### Terminal Setup
Install iTerm2:
```bash
brew install --cask iterm2
```

Set up Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Clone and setup theme -> Powerlevel10k:
```bash
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
Then edit `~/.zshrc` and set `ZSH_THEME="powerlevel10k/powerlevel10k"`


## Conda Environment Setup

### Install Miniconda
```bash
brew install --cask miniconda
```

### Initialize Conda for your shell
```bash
conda init zsh
```

Restart your terminal or run:
```bash
source ~/.zshrc
```

### Configure Conda
```bash
conda config --set auto_activate_base false  # Optional: prevent auto-activation of base env
conda config --set channel_priority strict
```

### Create Development Environments

Base Data Science Environment:
```bash
conda create -n datasci python=3.11 numpy pandas matplotlib seaborn scikit-learn jupyter jupyterlab statsmodels
```

ML/AI Environment:
```bash
conda create -n mlai python=3.10 
conda activate mlai
conda install -c apple tensorflow-deps
pip install tensorflow tensorflow-metal  # TensorFlow with Metal acceleration
pip install torch torchvision torchaudio
conda install numpy pandas matplotlib seaborn scikit-learn jupyter
```


### Install Visual Studio Code
```bash
brew install --cask visual-studio-code
```

Essential VS Code Extensions:
- Python
- Jupyter
- GitLens
- Docker
- Remote Development
- Prettier
- Python Indent

### Configure VS Code for Conda
- Open VS Code settings (Cmd+,)
- Search for "Python: Python Path"
- Add paths to conda environments

## Cross-Platform Development Tools

### Install Docker
```bash
brew install --cask docker
```

### Install Node.js and npm (for Frontend)
```bash
brew install node
```

### Install Git and Configure
```bash
brew install git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Generate SSH Key for GitHub/GitLab
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Then add to GitHub/GitLab:
```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
```


## Productivity Tools

### Install Essential Apps
```bash
brew install --cask rectangle  # Window management
brew install --cask notion     # Notes and project management
```

### Install Browser(s)
```bash
brew install --cask google-chrome firefox brave-browser
```

## Final Optimizations


### Install Maintenance Tools
```bash
brew install --cask appcleaner  # Clean app uninstalls
```

For system maintenance, you can use built-in macOS tools:
```bash
sudo periodic daily weekly monthly  # Runs the standard macOS maintenance scripts
```

### Create Conda Environment Export Script
Create a script to easily export your environments:
```bash
echo '#!/bin/bash
for env in $(conda env list | grep -v "^#" | awk "{print \$1}"); do
  if [ "$env" != "base" ] && [ -n "$env" ]; then
    echo "Exporting $env environment..."
    conda activate $env
    conda env export > "${env}_environment.yml"
  fi
done' > ~/export_conda_envs.sh
chmod +x ~/export_conda_envs.sh
```