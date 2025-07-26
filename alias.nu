# tool replacement
# alias ls = eza # not necessary for nushell
# alias lsa = eza -a
# alias lsl = eza -l -a
# alias cd = z # handled at 'zoxide init' in ./env.nu
alias cat = bat

# no more spam
# alias .. = cd .. # exists by default in nushell
# alias .... = cd ../..
# alias ...... = cd ../../..

# freq stuff
alias v = vim
alias vi = vim
alias nv = nvim
alias m = moon
alias chez = chezmoi
alias mp = mprocs
alias ko = kondo
alias g = git
alias cdr = cd (git rev-parse --show-toplevel | str trim)
alias cdn = cd ~/appdata/local/nvim
alias cdw = cd ~/.config/wezterm
alias cdc = cd ~/.local/share/chezmoi
alias cdq = cd ~/appdata/roaming/qutebrowser/config
alias cdp = cd ~/documents/projects
alias cdy = cd ~/.config/yasb
alias cdu = cd ~/appdata/roaming/nushell
