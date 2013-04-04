cp .alias .bash_profile .bashrc .vimrc .gitconfig $HOME/
if [ ! -d $HOME/bin ]
then
    mkdir $HOME/bin
fi
cp bin/* $HOME/bin

source $HOME/.bash_profile
