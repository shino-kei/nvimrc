# readme 

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
