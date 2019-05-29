dotfiles
============

## Setup
1. `git clone https://github.com/Laica-Lunasys/dotfiles`
2. `cd dotfiles; make install`

## Docker
```bash
docker pull lunasys/dotfiles
```
```bash
docker pull quay.io/lunasys/dotfiles
```

### Usage
```bash
docker run --rm --name luna-dotfiles \
    -v $HOME/.ssh:/home/relias/.ssh \
    -it lunasys/dotfiles
```
