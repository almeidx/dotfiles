# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\robbyrussell.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\emodipt-extend.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\amro.omp.json" | Invoke-Expression

fnm env --use-on-cd --shell powershell --resolve-engines | Out-String | Invoke-Expression

Import-Module PSReadLine

Remove-Item Alias:\gp -Force
Remove-Item Alias:\gcm -Force
Remove-Item Alias:\gcb -Force

function p    {	pnpm @args 													}
function nr		{ node --run @args										}

function g 		{ git @args														}
function ga 	{ git add @args												}
function gb 	{ git branch @args										}
function gca  { git commit --amend @args						}
function gcan { git commit --amend --no-edit @args 	}
function gcb 	{ git switch -c $args									}
function gcm 	{ git commit -m @args									}
function gco 	{ git checkout @args									}
function gd 	{ git diff @args											}
function gfa 	{ git fetch --all --prune @args				}
function gp 	{ git push @args											}
function gpf 	{ git push --force-with-lease @args		}
function gpr 	{ git pull --rebase @args							}
function gr   { git remote @args										}
function gst 	{ git status -sb @args								}
function gw 	{ git switch @args										}

function time {
	param (
		[Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
		[String[]]$Command
	)

	$scriptBlock = [scriptblock]::Create($Command -join " ")
	$result = Measure-Command -Expression $scriptBlock
	Write-Host "real		$($result.TotalSeconds)s"
}
