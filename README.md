# mydots ⚡

Este repositório usa o método **bare repo** para gerenciar dotfiles do `$HOME`.

Documentação completa:
- [`~/.dotfiles/README.md`](.dotfiles/README.md)

## Rápido

```bash
git clone --bare git@github.com:tutisFallen/mydots.git $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config status.showUntrackedFiles no
```

## Pacotes cross-distro

```bash
bash ~/.dotfiles/scripts/install-all.sh
```
