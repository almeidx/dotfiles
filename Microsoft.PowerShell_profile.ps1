oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\robbyrussell.omp.json" | Invoke-Expression

fnm env --use-on-cd --resolve-engines | Out-String | Invoke-Expression

Import-Module PSReadLine

function pnpm-shortcut { pnpm @args }
Set-Alias -Name pn -Value pnpm-shortcut

function git-add {             git add $args                     }
function git-branch {          git branch $args                  }
function git-branch-create {   git checkout -b $args             }
function git-checkout {        git checkout $args                }
function git-commit-message {  git commit -m $args               }
function git-diff {            git diff $args                    }
function git-fetch-all-prune { git fetch --all --prune $args     }
function git-pull-rebase {     git pull --rebase $args           }
function git-push {            git push $args                    }
function git-push-force {      git push --force-with-lease $args }
function git-status {          git status -sb $args              }
function git-switch {          git switch $args                  }

Remove-Item Alias:\gp -Force
Remove-Item Alias:\gcm -Force

Set-Alias -Name g  	-Value git
Set-Alias -Name ga  -Value git-add
Set-Alias -Name gb  -Value git-branch
Set-Alias -Name gcb -Value git-branch-create
Set-Alias -Name gco -Value git-checkout
Set-Alias -Name gcm -Value git-commit-message
Set-Alias -Name gd  -Value git-diff
Set-Alias -Name gfa -Value git-fetch-all-prune
Set-Alias -Name gpr -Value git-pull-rebase
Set-Alias -Name gst -Value git-status
Set-Alias -Name gp  -Value git-push
Set-Alias -Name gpf -Value git-push-force
Set-Alias -Name gw  -Value git-switch

function time {
    param (
        [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
        [String[]]$Command
    )

    $scriptBlock = [scriptblock]::Create($Command -join " ")
    $result = Measure-Command -Expression $scriptBlock
    Write-Host "real    $($result.TotalSeconds)s"
    Write-Host "user    $($result.TotalSeconds)s"
    Write-Host "sys     $($result.TotalSeconds)s"
}
