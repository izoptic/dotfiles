# Dotfiles (chezmoi)

Machine context is `personal` or `work`. Interactive `chezmoi init` prompts for it;
noninteractive setup must supply `CHEZMOI_CONTEXT=personal` or
`CHEZMOI_CONTEXT=work`. The choice is stored in the local chezmoi config, not Git.

## New Arch Linux machine (including Arch with BlackArch repositories)

Check `/etc/os-release` has `ID=arch`. Review and run a full system update at a
suitable time before provisioning; the chezmoi script **does not** run
`pacman -Syu` or refresh package databases (which could cause a partial upgrade).

```sh
sudo pacman -Syu --needed git chezmoi
CHEZMOI_CONTEXT=personal chezmoi init --apply https://github.com/izoptic/dotfiles.git
chezmoi status
```

The repository is readable over HTTPS; no GitHub SSH key is needed. The Arch
package script installs the shell utilities with `pacman -S --needed`; it does
not install BlackArch tools. Linux WezTerm keeps its maximize-on-start behavior
and uses Cousine Nerd Font (`ttf-cousine-nerd`); Zed settings remain macOS-only.
Chezmoi does not switch the login shell; change it to zsh separately if desired.

## macOS

Install Homebrew and chezmoi first, then run `chezmoi init --apply` with the
appropriate context as above. The macOS package script uses Homebrew.

Before applying updates on any machine, inspect `chezmoi status` and
`chezmoi diff`. `run_onchange_` package scripts may rerun when edited.
