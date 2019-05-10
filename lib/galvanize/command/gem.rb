require 'galvanize/command/base'
require 'rubygems'
require 'rubygems/gem_runner'
require 'rubygems/exceptions'

module Galvanize
  module Command
    # Forwards all commands to rubygems.
    class GemForwarder < Galvanize::Command::Base
      banner 'Usage: chef gem GEM_COMMANDS_AND_OPTIONS'

      def run(params)
        retval = Gem::GemRunner.new.run(params.clone)
        retval.nil? ? true : retval
      rescue Gem::SystemExitException => e
        exit(e.exit_code)
      end

      # Lazy solution: By automatically returning false, we force ChefDK::Base to
      # call this class' run method, so that Gem::GemRunner can handle the -v flag
      # appropriately (showing the gem version, or installing a specific version
      # of a gem).
      def needs_version?(_params)
        false
      end
    end
  end
end
