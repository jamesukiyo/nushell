# path
if ($nu.os-info.name == "windows") {
	$env.Path = ($env.Path | append 'C:\Users\james\.bun\bin')
} else if ($nu.os-info.name == "macos") {
	$env.Path = ($env.Path | append ["/opt/homebrew/bin", "/Users/james/.cargo/bin", "/Users/james/.bun", "/Users/james/.bun/bin"])
}
# carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense,clap' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# zoxide
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
