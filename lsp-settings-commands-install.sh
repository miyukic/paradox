#npm(node.js)
which npm
if [ $? = 1 ]; then
    echo "npmコマンドをインストールします"
    sudo apt install nodejs -y
    sudo apt install npm -y
else 
    echo "npmコマンドのインストールはスキップします"
fi

node --version
npm --version

installcommand=python
which $installcommand
if [ $? = 1 ]; then
    echo "${installcommand}コマンドをインストールします"
    sudo apt install nodejs -y
    sudo apt install "${installcommand}3" -y
else 
    echo "${installcommand}コマンドのインストールはスキップします"
fi

source ./install-python.sh
