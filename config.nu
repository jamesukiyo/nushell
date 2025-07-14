# hooks
source hooks.nu

# set
source set.nu

# aliases
source alias.nu

# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# menus
source menus.nu

# utils
source utils.nu

# completions
source cmp.nu

# carapace
source ~/.cache/carapace/init.nu

# zoxide
source ~/.zoxide.nu
