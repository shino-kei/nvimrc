#! /bin/sh

echo "installing dein"

if [ -e  $HOME/.cache/dein ]; then
  echo "dein already installed :skip"
else
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
  sh ./installer.sh ~/.cache/dein
  rm -f ./installer.sh
fi

