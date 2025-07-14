# path
$env.Path = ($env.Path | append 'C:\Users\james\.bun\bin')

# carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense,clap' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# zoxide
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
