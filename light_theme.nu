def main [] {
    let wezterm_file = 'c:\users\james\.config\wezterm\james\set_colorscheme.lua'
    let nvim_file = 'c:\users\james\appdata\local\nvim\lua\set_colorscheme.lua'
    let yasb_styles = 'c:\users\james\.config\yasb\styles.css'
    let yasb_light_styles = 'c:\users\james\.config\yasb\styles_light.css'
    let starship_config = 'c:\users\james\.config\starship.toml'
    let starship_light_config = 'c:\users\james\.config\starship_light.toml'

	let theme = "light_theme"

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
        let light_content = open $yasb_light_styles
        $light_content | save $yasb_styles --force
        print $"✓ set yasb theme to light"
    } catch { |e|
        print $"✗ failed to set yasb theme: ($e.msg)"
    }

    # set starship theme
    try {
        let light_content = open $starship_light_config
        $light_content | save $starship_config --force
        print $"✓ set starship theme to light"
    } catch { |e|
        print $"✗ failed to set starship theme: ($e.msg)"
    }
}
