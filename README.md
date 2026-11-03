# Dotfiles

Shared zsh, Powerlevel10k, WezTerm, Ghostty, Rectangle, and Zed configuration for macOS and Linux,
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

## Rectangle

Shortcut restoration is enabled for **graphical personal macOS machines**.
Work, headless, and Linux machines are excluded. It does not install Rectangle,
start/restart applications, change Accessibility permissions, or edit its cached
preferences plist. Tested with Rectangle 2.0.4 on eris.

Plain JSON profiles live in `.chezmoitemplates/rectangle/`:

- `mobile.json`: Control+Option+U/I/J/K for the four quarters.
- `desktop.json`: Control+Option+Home/Page Up/End/Page Down respectively.

`machine.mobile` selects the profile. Both preserve the other exported default
shortcuts, including Control+Option+arrows for halves, Return for Maximize, and
Backspace for Restore. All 22 baseline bindings are retained. `defaults: {}`
intentionally leaves non-shortcut preferences alone; login/update/snapping
settings are not restored by these profiles.

`run_onchange_after_20-rectangle.sh.tmpl` embeds the selected profile and stages
it at `~/Library/Application Support/Rectangle/RectangleConfig.json` when its
content changes. Rectangle imports it on launch, then consumes/renames the file;
the 2.0.4 source also requests Apply/Discard confirmation. The script never
restarts the app and refuses to overwrite a different pending import or symlink.

A private hash record at `~/.local/state/chezmoi-rectangle/last-staged.sha256`
prevents an unchanged configuration being queued again after consumption. This
records **staging**, not proof the user accepted the import. It is local runtime
state, not committed configuration. A new machine without this record stages
normally. After a Discard, app reset, or other intentional repeat restoration,
use `--restage` below; pending-file safety checks still apply.

### Targeted restoration without package provisioning

A configuration-only apply with `--exclude=scripts` does **not** stage Rectangle.
Until the existing package provisioning has been reviewed, do not use a full
apply merely to restore this app. Render and run only this hook instead:

```sh
source_dir=$(chezmoi source-path)
stage_script=$(mktemp /tmp/rectangle-stage.XXXXXX)
chezmoi execute-template < "$source_dir/run_onchange_after_20-rectangle.sh.tmpl" > "$stage_script"
/bin/sh "$stage_script" --restage
rm "$stage_script"
```

Then launch Rectangle yourself (quit/reopen it if already running), accept the
import if prompted, and test/export the result. Without `--restage`, the script
stages only changed content. Normal script-enabled applies will also run this
hook when its rendered contents change, alongside any other enabled hooks.

### Capture and verification

Export through Rectangle's App Settings. Review the shortcuts, normalize the
reviewed export to `defaults: {}` unless specific additional preferences have
been deliberately approved, then update the appropriate plain JSON profile.
Do not blindly capture the full export, licensing/runtime data, or the preferences
plist. Changes to common bindings should be reviewed in both profiles; keep the
intentional quarter differences. These are template inputs, not live targets,
so `chezmoi re-add` is not the capture mechanism. Review, test, commit, and push
verified changes before treating the work as complete.

The source does not continuously read back Rectangle's running preferences;
GUI changes must be explicitly exported and captured before restoration.
Offline tests (macOS, temporary homes only):

```sh
bash "$(chezmoi source-path)/.chezmoitemplates/rectangle/test-staging.sh"
```
