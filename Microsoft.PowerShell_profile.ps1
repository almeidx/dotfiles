oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\robbyrussell.omp.json" | Invoke-Expression

fnm env --use-on-cd --resolve-engines | Out-String | Invoke-Expression

Import-Module PSReadLine

function p    {	pnpm @args 													}

function g 		{ git @args														}
function ga 	{ git add @args												}
function gb 	{ git branch @args										}
function gcb 	{ git checkout -b @args								}
function gco 	{ git checkout @args									}
function gcm 	{ git commit -m @args									}
function gd 	{ git diff @args											}
function gfa 	{ git fetch --all --prune @args				}
function gpr 	{ git pull --rebase @args							}
function gp 	{ git push @args											}
function gpf 	{ git push --force-with-lease @args		}
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
	Write-Host "real    $($result.TotalSeconds)s"
}
