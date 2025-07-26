def main [] {
    let wezterm_file = 'c:\users\james\.config\wezterm\james\set_colorscheme.lua'
    let nvim_file = 'c:\users\james\appdata\local\nvim\lua\set_colorscheme.lua'
    let yasb_styles = 'c:\users\james\.config\yasb\styles.css'
    let yasb_dark_styles = 'c:\users\james\.config\yasb\styles_dark.css'
    let starship_config = 'c:\users\james\.config\starship.toml'
    let starship_dark_config = 'c:\users\james\.config\starship_dark.toml'

	let theme = "dark_theme"

    # set wezterm theme
    try {
        let content = open $wezterm_file
        let updated = $content
            | str replace --regex 'config\.color_scheme = \w+_theme' $'config.color_scheme = ($theme)'
        $updated | save $wezterm_file --force
        print $"✓ set wezterm theme to ($theme)"
    } catch { |e|
        print $"✗ failed to set wezterm theme: ($e.msg)"
    }

    # set neovim theme
    try {
        let content = open $nvim_file
        let updated = $content | str replace --regex 'local current_theme = \w+_theme' $'local current_theme = ($theme)'
        $updated | save $nvim_file --force
        print $"✓ set neovim theme to ($theme)"
    } catch { |e|
        print $"✗ failed to set neovim theme: ($e.msg)"
    }

    # set yasb theme
    try {
        let dark_content = open $yasb_dark_styles
        $dark_content | save $yasb_styles --force
        print $"✓ set yasb theme to dark"
    } catch { |e|
        print $"✗ failed to set yasb theme: ($e.msg)"
    }

    # set starship theme
    try {
        let dark_content = open $starship_dark_config
        $dark_content | save $starship_config --force
        print $"✓ set starship theme to dark"
    } catch { |e|
        print $"✗ failed to set starship theme: ($e.msg)"
    }
}
