# badge-lab

A public sandbox used to test and demonstrate GitHub workflow mechanics — pull
request reviews, squash merges, discussion threads, and profile achievements.

## Why it exists

Most GitHub profile achievements only trigger on real activity in a **public**
repository. `badge-lab` is a scratch space for that activity so it never pollutes
production code.

## Contents

| Path | Purpose |
|---|---|
| `notes.txt` | Trivial change used to exercise the merge flow. |
| `pair-extraordinaire.ps1` | Opens and merges a co-authored PR. |
| `ISSUE_BODY.md` | Body for the achievement tracker issue. |

## Usage

```powershell
# Merge a PR without a review
gh pr create --repo <owner>/badge-lab --title "..." --body "..."
gh pr merge <pr-number> --squash --delete-branch

# Co-authored merge
.\pair-extraordinaire.ps1 -CoAuthorUser theirhandle -Count 1
```

## Notes

- Co-author attribution only registers if the `Co-authored-by:` trailer email is
  verified on the co-author's GitHub account.
- Achievements are granted by GitHub automatically and can take a few minutes
  to appear on a profile.