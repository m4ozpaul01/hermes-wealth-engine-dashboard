#!/usr/bin/env bash
# ~/Desktop/FINANCE/DASHBOARD/GH_PAGES/publish.sh
#
# Regenerate the sanitised dashboard and publish it to GitHub Pages.
#
#   repo : https://github.com/m4ozpaul01/hermes-wealth-engine-dashboard
#   page : https://m4ozpaul01.github.io/hermes-wealth-engine-dashboard/
#
# Safe by construction: the generator strips emails, hostnames, absolute paths
# and credential state, and `audit()` REFUSES TO PUBLISH if anything sensitive
# survives. Run it as often as you like.
#
# AUTH NOTE: pushing needs the `gh` keyring credential, which is only available
# in an interactive user session. A launchd-managed process cannot read the
# login keyring, so this is NOT wired into the supervisor. To automate it, export
# a fine-grained token as GH_TOKEN scoped to this one repository, and schedule
# this script with `hermes cron create ... --script --no-agent` instead.

set -uo pipefail

DOC_ROOT="$HOME/Desktop/FINANCE"
ROOT="$(cd "$DOC_ROOT" && pwd -P)"
PY="/usr/bin/python3"
SITE="$ROOT/DASHBOARD/GH_PAGES"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

cd "$ROOT" || exit 1

echo "==> regenerating sanitised dashboard"
"$PY" -m CORE.gh_pages || { echo "generation failed"; exit 1; }

echo "==> auditing output for sensitive data"
AUDIT=$("$PY" - <<'EOF'
import sys, json
sys.path.insert(0, ".")
from CORE import gh_pages
a = gh_pages.audit_published_page()
print(json.dumps(a))
print("CLEAN" if a["clean"] else "DIRTY")
EOF
)
echo "$AUDIT"
if echo "$AUDIT" | tail -1 | grep -q DIRTY; then
  echo "REFUSING TO PUBLISH: sensitive data found in the generated page."
  echo "Inspect $SITE/index.html and fix CORE/gh_pages.py sanitisation."
  exit 1
fi

cd "$SITE" || exit 1
git add -A
if git diff --cached --quiet; then
  echo "==> no content change; nothing to publish"
  exit 0
fi

git commit -q -m "Refresh status dashboard ($(date -u +%Y-%m-%dT%H:%MZ))"
git push -q origin main && echo "==> pushed to $(git remote get-url origin)"
echo "==> live in ~1 min: https://m4ozpaul01.github.io/hermes-wealth-engine-dashboard/"
