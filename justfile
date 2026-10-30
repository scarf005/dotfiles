# scan every commit and the tracked files for secrets
audit:
    go run github.com/zricethezav/gitleaks/v8@v8.30.0 git --redact --no-banner .

# run gitleaks on every commit
install-hooks:
    prek install

# switch the reply persona to persona/<name>.md (eri, villainess, off); without a name, pick one with fzf
persona name="":
    #!/bin/sh
    set -eu
    n="{{name}}"
    [ -n "$n" ] || n=$(ls persona | sed -n 's/\.md$//p' | rg -vx active | fzf --header "now: $(readlink persona/active.md)")
    [ -f "persona/$n.md" ] || { echo "no persona/$n.md" >&2; exit 1; }
    ln -sfn "$n.md" persona/active.md
    echo "persona: $n"

# turn the persona off
persona-off: (persona "off")
