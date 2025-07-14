$env.config.hooks.display_output = {||
	if (term size).columns >= 100 { table -e } else { table }
}


$env.config.hooks.pre_prompt = [
	{ ||
	    if (which direnv | is-empty) {
		return
	    }
	    direnv export json | from json | default {} | load-env
	    $env.PATH = ($env.PATH | split row (char env_sep))
	}
]
