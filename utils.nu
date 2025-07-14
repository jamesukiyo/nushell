def "cargo search" [query: string, --limit=10] {
    ^cargo search $query --limit $limit
    | lines
    | each {
        |line| if ($line | str contains "#") {
            $line | parse --regex '(?P<name>.+) = "(?P<version>.+)" +# (?P<description>.+)'
        } else {
            $line | parse --regex '(?P<name>.+) = "(?P<version>.+)"'
        }
    }
    | flatten
}

def "cargo update-all" [] {
	cargo install --list
		| parse "{package} v{version}:"
		| get package
		| each {|p| cargo install $p}
}
def pwd [] {
  $env.PWD | str replace $nu.home-path '~'
}

def gitsummary [
    --count (-n): int = 999999
] {
    try {
        git log $"--pretty=%h»¦«%aN»¦«%s»¦«%aD" $"-($count)"
        | lines
        | split column "»¦«" sha1 committer desc merged_at
        | histogram committer merger
        | sort-by merger
        | reverse
    } catch {
        print "Error: Make sure you're in a git repository"
    }
}

def mega-update [] {
	cargo update-all ;
	scoop update --all ;
	winget upgrade --all --include-unknown
}
