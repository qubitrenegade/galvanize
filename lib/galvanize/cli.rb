
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
        err "Unknown command `#{subcommand_name}'."
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
    end

    def exit(n)
      Kernel.exit(n)
    end

    def option?(param)
      param =~ /^-/
    end

    private

    def sanity_check!
      true
    end
  end
end
