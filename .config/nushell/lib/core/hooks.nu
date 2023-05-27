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
  command_not_found: {||
    null  # replace with source code to return an error message when a command is not found
  }

  #TODO: add autols template
  env_change: {
    PWD: [{|before, after|
      $nothing  # replace with source code to run if the PWD environment is different since the last repl input
    }]
  }
  
} }