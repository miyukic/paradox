# python3
sudo apt update
sudo apt install python3 -y

#pyenv依存関係
sudo apt install \
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl llvm \
  libncursesw5-dev tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  libopencv-dev gitpyenv

#pyenvのダウンロード
if [ -d ~/.pyenv ]; then
    echo ".pyenvディレクトリがすでに存在しています"
    #pyenv update
    #pyenv versions
else
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    #pyencupdate用
    git clone git://github.com/yyuu/pyenv-update.git ~/.pyenv/plugins/pyenv-update
fi

#pyencインストール
MYBASHRC_FILE=".mybashrc"
if [ -L ~/.mybashrc ]; then
    cat ~/.mybashrc | grep -P "^export PYENV_ROOT=\".*"
    if [ $? -ne 0 ]; then
        echo pyenvを~/.mybashrcにインストールします
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/${MYBASHRC_FILE}
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/${MYBASHRC_FILE}
        echo 'eval "$(pyenv init -path)"' >> ~/${MYBASHRC_FILE}
        source ~/.bashrc
        echo .bashrcを再読込しました
    else
        echo "すでに記述されています"
    fi
else
    echo "~/.mybashrcがありません"
    echo "~/.mybashrcを配置してください"
fi

