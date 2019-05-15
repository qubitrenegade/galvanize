require 'bundler/setup'
require 'chef-dk/cli'
require 'chef-dk/command/generator_commands/habichef'

module Galvanize
  def self.skeletons_dir
    File.join __dir__, 'galvanize', 'skeletons'
  end
end
