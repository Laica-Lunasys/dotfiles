dotfiles
============

![ScreenShot](https://imgur.com/n3e3ajU.png)

## Setup
1. `git clone https://github.com/Laica-Lunasys/dotfiles`
2. `cd dotfiles; bash ./init.sh install`
> Also, you can use `make install`

## Docker
```bash
docker pull ghcr.io/laica-lunasys/dotfiles:latest
```

### Usage
```bash
docker run --rm --name luna-dotfiles \
    -e TZ=Asia/Tokyo \
    -v $HOME/.ssh:/home/relias/.ssh \
    -it ghcr.io/laica-lunasys/dotfiles:latest
```

### vim (neovim)
If you want to use lsp, you should be execute `:LspInstallServer` while editing a file.
