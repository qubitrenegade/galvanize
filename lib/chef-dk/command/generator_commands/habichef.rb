require 'chef-dk/command/generator_commands/base'

module ChefDK
  module Command
    module GeneratorCommands
      class HabiChef < Base
        banner 'Usage: galvanize generate habichef NAME [options]'

        attr_reader :errors
        attr_reader :habichef_name_or_path

        options.merge!(SharedGeneratorOptions.options)

        def initialize(params)
          @params_valid = true
          @habichef_name = nil
          @verbose = false
          super
        end

        def run
          read_and_validate_params
          if params_valid?
            setup_context
            puts %(I'm running !!!)

            chef_runner.converge
            0
          else
            err(opt_parser)
            1
          end
        rescue ChefDK::ChefRunnerError => e
          err "ERROR: #{e}"
        end

        def setup_context
          super
          Generator.add_attr_to_context(:habichef_name, habichef_name)
          Generator.add_attr_to_context(:habichef_root, habichef_root)
        end

        def habichef_name
          File.basename habichef_full_path
        end

        def habichef_root
          File.dirname habichef_full_path
        end

        def habichef_full_path
          File.expand_path habichef_name_or_path, Dir.pwd
        end

        def read_and_validate_params
          arguments = parse_options(params)
          @habichef_name_or_path = arguments[0]
          @params_valid = false unless @habichef_name_or_path
          true
        end

        def recipe
          'habichef'
        end

        def params_valid?
          @params_valid
        end
      end
    end
  end
end
