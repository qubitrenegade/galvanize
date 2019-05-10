Galvanize.commands do |c|
  c.builtin 'exec', :Exec, require_path: 'galvanize/command/exec',
                           desc: 'Runs the command in context of the embedded ruby'

  c.builtin 'gem', :GemForwarder, require_path: 'galvanize/command/gem',
                                  desc: 'Runs the `gem` command in context of the embedded ruby'
  c.builtin 'generate', :Generate, desc: 'Generate a new app, cookbook, or component'
end
