require 'galvanize/helpers'
require 'galvanize/commands_map'
require 'galvanize/builtin_commands'

module Galvanize
  class CLI
    include Mixlib::CLI

    banner(<<~BANNER)
      Usage:
        galvanize -h/--help
        galvanize -v/--version
        galvanize command [arguments] <options>
    BANNER

    option :version,
      short: '-v',
      long: '--version',
      description: 'Show chef version',
      boolean: true

    option :help,
      short: '-h',
      long: '--help',
      description: 'Show this message',
      boolean: true

    attr_reader :argv

    def initialize(argv)
      @argv = argv
      super() # mixlib-cli #initialize doesn't allow arguments
    end

    def run
      sanity_check!

      subcommand_name, *subcommand_params = argv

      #
      # Runs the appropriate subcommand if the given parameters contain any
      # subcommands.
      #
      if subcommand_name.nil? || option?(subcommand_name)
        handle_options
      elsif have_command?(subcommand_name)
        subcommand = instantiate_subcommand(subcommand_name)
        exit_code = subcommand.run_with_default_options(subcommand_params)
        exit normalized_exit_code(exit_code)
      else
        # err "Unknown command `#{subcommand_name}'."
        msg "Unknown command `#{subcommand_name}'."
        show_help
        exit 1
      end
    rescue OptionParser::InvalidOption => e
      err(e.message)
      show_help
      exit 1
    end

    # If no subcommand is given, then this class is handling the CLI request.
    def handle_options
      parse_options(argv)
      if config[:version]
        show_version
      else
        show_help
      end
      exit 0
    end

    def show_version
      puts "Version: #{Galvanize::VERSION}"
    end

    def show_help
      puts banner
      puts "\nAvailable Commands:"

      justify_length = subcommands.map(&:length).max + 2
      subcommand_specs.each do |name, spec|
        next if spec.hidden
        puts "    #{name.to_s.ljust(justify_length)}#{spec.description}"
      end
    end

    def exit(n)
      Kernel.exit(n)
    end

    def commands_map
      Galvanize.commands_map
    end

    def have_command?(name)
      true || commands_map.have_command?(name)
    end

    def subcommands
      commands_map.command_names
    end

    def subcommand_specs
      commands_map.command_specs
    end

    def option?(param)
      param =~ /^-/
    end

    def instantiate_subcommand(name)
      commands_map.instantiate(name)
    end

    private

    def normalized_exit_code(maybe_integer)
      if maybe_integer.is_a?(Integer) && (0..255).cover?(maybe_integer)
        maybe_integer
      else
        0
      end
    end

    def sanity_check!
      true
    end
  end
end
