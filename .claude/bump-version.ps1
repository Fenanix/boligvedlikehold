# bump-version.ps1
# PreToolUse hook: bumps the patch digit in index.html before every git commit.
$json = [Console]::In.ReadToEnd() | ConvertFrom-Json
if ($json.tool_input.command -notmatch 'git commit') { exit 0 }

$dir   = 'C:\Users\ice_c\Projects\boligvedlikehold'
$file  = Join-Path $dir 'index.html'
if (-not (Test-Path $file)) { exit 0 }

$c = [System.IO.File]::ReadAllText($file)
if ($c -match "version:\s+'(\d+)\.(\d+)\.(\d+)'") {
    $oldVer = "$($Matches[1]).$($Matches[2]).$($Matches[3])"
    $newVer = "$($Matches[1]).$($Matches[2]).$([int]$Matches[3] + 1)"
    $c = $c.Replace($oldVer, $newVer)
    [System.IO.File]::WriteAllText($file, $c)
    & git -C $dir add index.html
}
