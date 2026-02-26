# mydots ⚡

Meu setup pessoal de dotfiles (Arch + Hyprland), incluindo:

- **Hyprland** (`~/.config/hypr`)
- **Yazi** (`~/.config/yazi`)
- **Fastfetch** (`~/.config/fastfetch`)
- **DankMaterialShell** (`~/.config/DankMaterialShell`)
- **Startpage do Firefox** (`~/.dotfiles/startpage.html`)

---

## Como usar em outro sistema

> Este repositório está no formato **bare repo** (estilo Atlassian), não no modelo comum com symlink manager.

### Instalação rápida (recomendada)

```bash
git clone --bare git@github.com:tutisFallen/mydots.git $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config status.showUntrackedFiles no
```

Se der conflito de arquivos existentes, use:

```bash
bash ~/.dotfiles/bootstrap.sh git@github.com:tutisFallen/mydots.git
```

Esse script faz backup automático em `~/.dotfiles-backup` e tenta checkout de novo.

---

## Comandos do dia a dia

Adicione este alias no shell:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Fluxo normal:

```bash
dotfiles status
dotfiles add .config/hypr .config/yazi .config/fastfetch .config/DankMaterialShell .dotfiles/startpage.html
dotfiles commit -m "update: configs"
dotfiles push
```

---

## Firefox Startpage

A homepage está em:

`file:///home/tutis/.dotfiles/startpage.html`

Para usar também na **Nova Aba**, instale a extensão **New Tab Override**.

---

## Observações

- Não versionar segredos (tokens, chaves privadas, cookies).
- Se quiser, depois posso migrar para modelo com **GNU Stow** (symlinks automáticos por pasta).


---

## Instalação de pacotes por distro

Scripts prontos em `~/.dotfiles/scripts`:

- `install-all.sh` (auto-detect distro)
- `install-arch.sh`
- `install-fedora.sh`
- `install-ubuntu.sh`

Uso (interativo por módulos):

```bash
bash ~/.dotfiles/scripts/install-all.sh
```

Uso não-interativo (instala tudo com default):

```bash
bash ~/.dotfiles/scripts/install-all.sh --yes
```

### Notas importantes

- Fedora: script tenta habilitar COPR `avengemedia/dms` para `dms` e `cliphist`.
- Ubuntu/Fedora: se `hyprland`/`yazi` não estiverem nos repositórios atuais, o script aponta para instalação oficial:
  - Hyprland: https://wiki.hypr.land/Getting-Started/Installation/
  - Yazi: https://yazi-rs.github.io/docs/installation/
- Fastfetch (Ubuntu fallback): https://github.com/fastfetch-cli/fastfetch
- Swappy (Ubuntu referência): https://launchpad.net/ubuntu/+source/swappy
