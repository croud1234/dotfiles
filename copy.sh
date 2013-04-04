cp .alias .bash_profile .bashrc .vimrc .gitconfig $HOME/
if [ ! -d $HOME/bin ]
then
    mkdir $HOME/bin
fi

if [ ! -d $HOME/.ssh ]
then
    mkdir $HOME/.ssh
fi

cp bin/* $HOME/bin
cp .ssh/* $HOME/.ssh

source $HOME/.bash_profile
