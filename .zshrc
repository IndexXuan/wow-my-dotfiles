# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"

echo
echo "=============== Quote Of The Day ==============="
echo
fortune
echo
echo "================================================"
echo

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
ZSH_THEME_RANDOM_CANDIDATES=( "re5et" "tjkirch_mod" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  git
  autojump
  sudo
)

source $ZSH/oh-my-zsh.sh

# 20170112: finally set default edit
export EDITOR=/usr/bin/vim

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ----- shortcut ----- #
alias restart="source $HOME/.zshrc"
alias c="clear"

alias l="ls -al"
alias ll="ls -al"
alias lll="ls -al"

# Vim
# Alias Vim as NeoVim
# brew install --HEAD neovim 安装命令
# https://zhuanlan.zhihu.com/p/383707713 国内 homebrew 源可能有坑
alias vim="nvim"
alias ovim="/usr/bin/vim"

# 急速 Vim
alias v="vim -u NONE"
# 基础 Vim
alias vv="BASIC_MODE=1 vim"
# Alias vi for Vim
alias vi="vim"
# Vim Perf Debug
alias vim-debug="vim --startuptime ~/.vim/debug/startuptime.log"

alias gitlog="git log --graph --oneline --all --decorate --color"
alias gitlist="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias git-soft-remove-last-commit="git reset --soft HEAD^"
alias github-remove-last-commit="git push -f origin HEAD^:master && git reset --soft HEAD^"
alias gitlist="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias branchlist="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias gcg="git checkout gh-pages"
alias gitreset="git reset --hard HEAD"

# npm
alias mmp="mnpm publish"
alias i="npm install --save-dev"
alias ig="sudo npm install -g"

# 磁盘空间统计
alias howmuch="sudo du -h --max-depth=1"

alias t="tree -L 2 ./"
alias tree="tree -L 2 ./"
alias t2="tree -L 2 ./"
alias tt="tree -L 3 ./"
alias t3="tree -L 3 ./"

# code count
alias cloc="scc --not-match='__' --exclude-dir=node_modules,public,build,tests,coverage,bin,.rome,.best,.doctor,.vscode,doc,docs,generated,_json.dart,.g.dart,json_diff"
alias jscode="find . ! -path './node_modules/*' -name '*.js' | xargs cat | grep -v ^$ | wc -l"
alias tscode="find . ! -path './node_modules/*' -name '*.ts' | xargs cat | grep -v ^$ | wc -l"
alias jsxcode="find . ! -path './node_modules/*' -name '*.jsx' | xargs cat | grep -v ^$ | wc -l"
alias tsxcode="find . ! -path './node_modules/*' -name '*.tsx' | xargs cat | grep -v ^$ | wc -l"
alias vuecode="find . ! -path './node_modules/*' -name '*.vue' | xargs cat | grep -v ^$ | wc -l"
alias scsscode="find . ! -path './node_modules/*' -name '*.scss' | xargs cat | grep -v ^$ | wc -l"
alias htmlcode="find . ! -path './node_modules/*' -name '*.html' | xargs cat | grep -v ^$ | wc -l"

# normalize dir & file
alias chmoddir="find ./ -type d -exec chmod 755 {} \;"
alias chmodfile="find ./ -type f -exec chmod 644 {} \;"
alias chmodall="chmoddir && chmodfile"

# ----- Apps ----- #
alias mnpm="npm --registry=http://r.npm.sankuai.com \
--cache=$HOME/.cache/mnpm \
--disturl=http://npm.sankuai.com/mirrors/node \
--userconfig=$HOME/.npmrc"

alias x="proxychains4"

alias create-zone-app="vue create --preset direct:ssh://git@git.sankuai.com/nibfe/vue-cli-preset-zone.git --clone my-zone-app"

alias shici="fortune-zh"
alias sc="fortune-zh"

alias mingju="fortune"
alias mj="fortune"

alias zhuangbi="cmatrix"
alias zb="cmatrix"

alias can="caniuse"

# alias vue-typecheck="npx @vuedx/typecheck"
alias vue-typecheck="npx vti diagnostics"
alias cpd="curl https://awp-assets.sankuai.com/hfe/talos-plugins/services/jscpd/index.js | node -"
alias vti="cd ${projectRoot:-.} && curl https://awp-assets.sankuai.com/hfe/talos-plugins/services/vue-typecheck-staging/index.js | node -"
alias cc="conard cc"

alias devtools="flutter pub global run devtools"

# nvm
export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

# Flutter
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH=$HOME/flutter-sdk/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/ossutil"
export PATH="$PATH":"$HOME/chrome-driver"


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
