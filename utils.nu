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

def "cargo update-all" [--force] {
    cargo install --list
        | parse "{package} v{version}:"
        | get package
        | each {|p|
            if $force {
                cargo install --locked --force $p
            } else {
                cargo install --locked $p
            }
        }
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

def mega-update [--force (-f), --yes (-y)] {
    # confirmation check
    if $force and not $yes and not (input "Force update all packages? (y/n): " | str starts-with "y") {
        return
    }

    let par_results = ["cargo", "scoop"] | par-each { |manager|
        try {
            print $"Starting ($manager)..."
            if $manager == "cargo" {
                if $force {
                    do -i { cargo update-all --force }
                } else {
                    do -i { cargo update-all }
                }
            } else if $manager == "scoop" {
                if $force {
                    do -i { scoop update --all --force }
                } else {
                    do -i { scoop update --all }
                }
            }
            print $"✓ ($manager) completed"
            { manager: $manager, status: "success" }
        } catch { |e|
            print $"✗ ($manager) failed: ($e.msg)"
            { manager: $manager, status: "failed", error: $e.msg }
        }
    }

    # winget alone for input
    let winget_result = try {
        print "Starting winget..."
        if $force {
            do -i { winget upgrade --all --interactive --force }
        } else {
            do -i { winget upgrade --all --interactive }
        }
        print "✓ winget completed"
        { manager: "winget", status: "success" }
    } catch { |e|
        print $"✗ winget failed: ($e.msg)"
        { manager: "winget", status: "failed", error: $e.msg }
    }

    let all_results = $par_results | append $winget_result

    print "\nAll updates finished"

    $all_results
}
