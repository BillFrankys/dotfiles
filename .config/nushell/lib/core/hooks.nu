export def main [] { return {
  pre_prompt: [{
    $nothing  # replace with source code to run before the prompt is shown
  }]
  pre_execution: [{
    $nothing  # replace with source code to run before the repl input is run
  }]

  #TODO: add this hook
  display_output: {||
    if (term size).columns >= 100 { table -e } else { table }
  }
  command_not_found: {|cmd_name|
	(
	try { 
	let pkgs = (cargo search --limit 15 $cmd_name)
	 if ($pkgs | is-empty) {
                        return null
                    }
	(		$"\n" +
                        $"($cmd_name) " +
                        $"may be found in the following crates:\n($pkgs)" | nu-highlight
                    )
		}
	)
  }

  #TODO: add autols template
  env_change: {
    PWD: [{|before, after|
      lsd   --git  --gitsort --long --hyperlink always   --total-size
    }]
  }
  
} }
