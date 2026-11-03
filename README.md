# Dotfiles

Shared zsh, Powerlevel10k, WezTerm, Ghostty, and Zed configuration for macOS and Linux,
managed with [chezmoi](https://www.chezmoi.io/) using local machine properties.

A full apply also checks and installs declared package dependencies.
Use `chezmoi apply --exclude=scripts` for configuration-only application.

## Ghostty

The complete normal config is managed as a plain file at
`~/.config/ghostty/config.ghostty`, on graphical **personal** macOS and Linux
machines. Work and headless machines are currently excluded. Requires Ghostty
**1.4 or newer** and Cousine Nerd Font. Ghostty itself is not added to package
provisioning by this configuration change.

All selected overrides are included: font/spacing, themes, cursor, scrollback,
window dimensions, Option-key behaviour, and custom keybindings. There is no
unmanaged local override. `super` means Command on macOS and Windows/Meta/Super
on Linux; `alt` means Option on macOS and Alt on Linux. Linux desktop shortcuts
may intercept a binding before it reaches Ghostty. The macOS-specific Option
setting has no effect on Linux.

Only this config is managed, not application plists, window/session state, font
files, or other application data. Do not dump all resolved/default settings into
the config: theme palettes and environment-derived defaults need not be frozen.
Avoid a second active config at the macOS Application Support location.

To capture intentional edits, then review the source changes:

```sh
chezmoi re-add ~/.config/ghostty/config.ghostty
chezmoi git -- diff
```

To review and apply only Ghostty, without provisioning scripts:

```sh
chezmoi diff --exclude=scripts ~/.config/ghostty/config.ghostty
chezmoi apply --exclude=scripts ~/.config/ghostty/config.ghostty
```

Do not apply over intentional local edits before capturing them. Reload Ghostty
after applying; some changes require a new terminal window. Source file:
`dot_config/ghostty/private_config.ghostty` (`private_` preserves mode 0600; the
file is not encrypted). Review and commit only the intended repository changes.
