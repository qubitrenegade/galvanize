
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'galvanize/version'

Gem::Specification.new do |spec|
  spec.name          = 'galvanize'
  spec.version       = Galvanize::VERSION
  spec.authors       = ['qubitrenegade']
  spec.email         = ['qubitrenegade@gmail.com']

  spec.summary       = 'This project aims to provide an easy to use framework for generating templates'
  # spec.description   = %q{TODO: Firgure a way to read the README in?}
  spec.homepage      = 'https://github.com/qubitrenegade/galvanize'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
