# readme 

## install neovim
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

## install dein
```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
sh ./installer.sh ~/.cache/dein
```

## depends
```bash
sudo apt install clang-6.0 clang-tools-6.0 llvm
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-6.0 100
```

```
cd ~/.config
git clone https://github.com/shino-kei/nvim_init.git
```

## reference 
[Ubuntu18.04でneovim(or vim8)+LanguageClient-neovim+clangdでC++の補完をする](https://kurokoji.hatenablog.com/entry/2018/08/16/220524)
