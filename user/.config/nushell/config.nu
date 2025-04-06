alias g = git
alias ga = git add
alias gaa = git add --all
alias gapa = git add --patch
alias gb = git branch
alias gba = git branch --all
alias gbd = git branch --delete
alias gc = git commit
alias gcam = git commit --all --message
alias gcb = git checkout -b
alias gcm = git checkout main
alias gcd = git checkout develop
alias gco = git checkout
alias gcp = git cherry-pick
alias gd = git diff
alias gf = git fetch
alias gl = git pull
alias gm = git merge
alias gp = git push
alias gpd = git push --dry-run
alias gpsup = git push --set-upstream origin
alias gr = git remote
alias grb = git rebase
alias grba = git rebase --abort
alias grbc = git rebase --continue
alias grbs = git rebase --skip
alias grs = git restore
alias grst = git restore --staged
alias gst = git status
alias gsb = git status --short --branch
alias gsh = git show
alias gss = git status --short
alias gsta = git stash push
alias gstp = git stash pop
alias gstl = git stash list

alias c = clear
alias grep = rg
alias lsusb = cyme
alias cat = bat -p --theme ansi

# alias ls = eza
alias l = ls -la      #size,show type,human readable
alias la = ls -la     #long list,show almost all,show type,human readable
alias lr = ls -t      #sorted by date,recursive,show type,human readable
alias lt = ls -lth    #long list,sorted by date,show type,human readable
alias ll = ls -l      #long list
alias ldot = ls -ld .*

alias grep = grep --color
alias sgrep = grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}

alias h = history
alias hgrep = fc -El 0 | grep

# Starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Carapace autocomplete
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
source ~/.cache/carapace/init.nu

# Remove welcome message
$env.config.show_banner = false
