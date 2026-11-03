#!/bin/bash
# Offline tests: all generated imports and state stay under temporary HOME dirs.
set -euo pipefail
repo=$(cd "$(dirname "$0")/../.." && pwd)
work=$(mktemp -d /tmp/rectangle-chezmoi-tests.XXXXXX)
hook="$repo/run_onchange_after_20-rectangle.sh.tmpl"
profiles="$repo/.chezmoitemplates/rectangle"
printf 'Test fixtures: %s\n' "$work"

for profile in desktop mobile; do
    mobile=false
    if [ "$profile" = mobile ]; then mobile=true; fi
    chezmoi --source "$repo" --override-data \
        "{\"machine\":{\"scope\":\"personal\",\"headless\":false,\"mobile\":$mobile}}" \
        execute-template < "$hook" > "$work/$profile.sh"
    /bin/sh -n "$work/$profile.sh"
    home="$work/$profile-home"
    mkdir -p "$home"
    HOME="$home" /bin/sh "$work/$profile.sh"
    target="$home/Library/Application Support/Rectangle/RectangleConfig.json"
    cmp "$target" "$profiles/$profile.json"
    test "$(stat -f %Lp "$target")" = 600
    test ! -L "$target"
    mv "$target" "$home/imported.json"
    HOME="$home" /bin/sh "$work/$profile.sh"
    test ! -e "$target"
    printf '%s: correct profile, private regular file, no repeat after consumption.\n' "$profile"
done

home="$work/desktop-home"
target="$home/Library/Application Support/Rectangle/RectangleConfig.json"
stamp="$home/.local/state/chezmoi-rectangle/last-staged.sha256"
HOME="$home" /bin/sh "$work/desktop.sh" --restage
cmp "$target" "$profiles/desktop.json"
cp "$stamp" "$work/stamp-before-conflict"
if HOME="$home" /bin/sh "$work/mobile.sh"; then
    printf 'ERROR: overwrote a conflicting pending import.\n' >&2
    exit 1
fi
cmp "$target" "$profiles/desktop.json"
cmp "$stamp" "$work/stamp-before-conflict"
mv "$target" "$home/restaged.json"
HOME="$home" /bin/sh "$work/mobile.sh"
cmp "$target" "$profiles/mobile.json"
printf 'Explicit re-stage, conflict refusal, and changed-profile staging passed.\n'

home="$work/symlink-home"
target="$home/Library/Application Support/Rectangle/RectangleConfig.json"
mkdir -p "$(dirname "$target")"
cp "$profiles/desktop.json" "$work/protected.json"
ln -s "$work/protected.json" "$target"
if HOME="$home" /bin/sh "$work/desktop.sh"; then
    printf 'ERROR: accepted a symlinked import.\n' >&2
    exit 1
fi
test -L "$target"
cmp "$work/protected.json" "$profiles/desktop.json"
printf 'Symlink refusal passed.\n'

for data in \
    '{"machine":{"scope":"work","mobile":false,"headless":false}}' \
    '{"machine":{"scope":"personal","mobile":false,"headless":true}}' \
    '{"chezmoi":{"os":"linux","osRelease":{"id":"arch"}},"machine":{"scope":"personal","mobile":false,"headless":false,"vulkan":"unknown"}}'; do
    chezmoi --source "$repo" --override-data "$data" execute-template \
        < "$hook" > "$work/excluded.sh"
    test ! -s "$work/excluded.sh"
done
printf 'Work/headless/Linux exclusions passed (template checks only).\n'

# Exercise chezmoi itself with an isolated source: no package hooks can run.
engine_source="$work/engine-source"
engine_home="$work/engine-home"
mkdir -p "$engine_source/.chezmoitemplates/rectangle" "$engine_home"
cp "$repo/.chezmoitemplates/validate-machine" "$engine_source/.chezmoitemplates/"
cp "$profiles/mobile.json" "$profiles/desktop.json" "$engine_source/.chezmoitemplates/rectangle/"
cp "$hook" "$engine_source/"
printf '%s\n' '[data.machine]' 'scope = "personal"' 'mobile = false' 'headless = false' \
    > "$work/engine-config.toml"
apply_fixture() {
    HOME="$engine_home" chezmoi --config "$work/engine-config.toml" \
        --source "$engine_source" --destination "$engine_home" \
        --persistent-state "$work/engine-state.boltdb" apply --include=scripts
}
apply_fixture
target="$engine_home/Library/Application Support/Rectangle/RectangleConfig.json"
cmp "$target" "$profiles/desktop.json"
mv "$target" "$engine_home/imported.json"
apply_fixture
test ! -e "$target"
# Change only an included JSON file, not the hook, to verify dependency hashing.
cp "$profiles/mobile.json" "$engine_source/.chezmoitemplates/rectangle/desktop.json"
apply_fixture
cmp "$target" "$profiles/mobile.json"
printf 'Native run_onchange: first restore, unchanged skip, and JSON-change trigger passed.\n'
printf 'All Rectangle staging tests passed.\n'
