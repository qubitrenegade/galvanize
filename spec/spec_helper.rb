require 'bundler/setup'
require 'galvanize'

RSpec.configure do |config|
  # Use documentation format
  config.formatter = 'doc'

  # run the examples in random order
  # config.order = :rand

  # Use color in STDOUT
  config.color = true

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
