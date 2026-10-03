param(
  [Parameter(Mandatory = $true)][string]$CoAuthorUser,
  [string]$CoAuthorEmail,
  [string]$Repo = "TanimowoObaloluwaDavid/badge-lab",
  [int]$Count = 1
)

if (-not $CoAuthorEmail) {
  $CoAuthorEmail = "$CoAuthorUser@users.noreply.github.com"
}

$stamp = Get-Date -Format "yyyyMMddHHmmss"
$slug = $CoAuthorUser -replace '[^A-Za-z0-9]', ''

for ($i = 1; $i -le $Count; $i++) {
  $branch = "pair-$slug-$stamp-$i"
  $file = "pair-$slug-$stamp-$i.md"

  git checkout main 2>&1 | Out-Null
  git pull --ff-only 2>&1 | Out-Null
  git checkout -b $branch 2>&1 | Out-Null

@"
# Pair Extraordinaire run $i

Branch: $branch
Co-author: $CoAuthorUser <$CoAuthorEmail>
"@ | Out-File -FilePath $file -Encoding utf8

  git add $file 2>&1 | Out-Null

  $subject = "chore: pair session $i with $CoAuthorUser"
  $body = "$subject`n`nCo-authored-by: $CoAuthorUser <$CoAuthorEmail>"

  git commit -m $body 2>&1 | Out-Null
  git push -u origin $branch 2>&1 | Out-Null

  $prUrl = gh pr create --repo $Repo --base main --head $branch --title $subject --body "Co-authored merge to earn the Pair Extraordinaire badge." 2>&1 | Select-Object -Last 1
  Write-Host "PR: $prUrl"

  gh pr merge $prUrl --repo $Repo --squash --delete-branch 2>&1 | Out-Null
  Write-Host "merged $branch"
}