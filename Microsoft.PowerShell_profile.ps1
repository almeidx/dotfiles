$script:e				= [char]27
$script:lambda	= [char]0x03BB
$script:cPath		= "$script:e[38;2;12;160;216m"
$script:cGit		= "$script:e[38;2;20;165;174m"
$script:cRoot		= "$script:e[38;2;205;94;66m"
$script:cText		= "$script:e[38;2;205;66;119m"
$script:reset		= "$script:e[0m"
$script:iFolder	= [char]0xF07B
$script:iRoot		= [char]0xE3BF
$script:iBranch	= [char]0xE0A0
$script:isAdmin	= ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$script:gitStopDirs = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$script:gitStopDirs.Add([System.IO.Path]::GetPathRoot($env:USERPROFILE)) > $null
$script:gitStopDirs.Add($env:USERPROFILE) > $null
$script:gitStopDirs.Add((Split-Path $env:USERPROFILE -Parent)) > $null

$script:gitCache = @{}

function prompt {
	$path = $pwd.Path
	$curDir = $path
	if ($path.StartsWith($env:USERPROFILE)) {
		$path = $path.Replace($env:USERPROFILE, "~")
	}
	$path = $path.Replace('\', '/')

	$out = "$script:cPath$script:iFolder $path "

	$inGit = $false
	if ($script:gitCache.ContainsKey($curDir)) {
		$inGit = $script:gitCache[$curDir]
	} else {
		$dir = $curDir
		while ($dir -and -not $script:gitStopDirs.Contains($dir)) {
			if ([System.IO.Directory]::Exists([System.IO.Path]::Combine($dir, '.git'))) {
				$inGit = $true
				break
			}
			$dir = [System.IO.Path]::GetDirectoryName($dir)
		}

		$script:gitCache[$curDir] = $inGit
	}

	if ($inGit) {
		$branch = git symbolic-ref --short HEAD 2>$null
		if ($LASTEXITCODE -ne 0) {
			$branch = git rev-parse --short HEAD 2>$null
		}
		if ($branch) {
			$out += "$script:cGit$script:iBranch $branch"
		}
	}

	$out += "`n"

	if ($script:isAdmin) {
		$out += "$script:cRoot$script:iRoot "
	}

	$out += "$script:cText$script:lambda $script:reset"

	return $out
}

fnm env --use-on-cd --shell powershell --resolve-engines | Out-String | Invoke-Expression

Import-Module PSReadLine

Remove-Item Alias:\gp -Force
Remove-Item Alias:\gcm -Force
Remove-Item Alias:\gcb -Force

function p		{	pnpm @args 													}
function nr		{ node --run @args										}

function g		{ git @args														}
function ga		{ git add @args												}
function gb		{ git branch @args										}
function gca	{ git commit --amend @args						}
function gcan	{ git commit --amend --no-edit @args	}
function gcb	{ git switch -c $args									}
function gcm	{ git commit -m @args									}
function gco	{ git checkout @args									}
function gd		{ git diff @args											}
function gfa	{ git fetch --all --prune @args				}
function gp		{ git push @args											}
function gpf	{ git push --force-with-lease @args		}
function gpr	{ git pull --rebase @args							}
function gr		{ git remote @args										}
function gst	{ git status -sb @args								}
function gw		{ git switch @args										}

function time {
	param (
		[Parameter(Mandatory, ValueFromRemainingArguments)]
		[String[]]$Command
	)

	$sb = [scriptblock]::Create($Command -join " ")
	$result = Measure-Command -Expression { & $sb | Out-Default }
	Write-Host "real		$($result.TotalSeconds.ToString('F3'))s"
}
