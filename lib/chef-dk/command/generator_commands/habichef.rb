require 'galvanize'
require 'chef-dk/command/generate'
require 'chef-dk/command/generator_commands/base'

module ChefDK
  module Command
    class Generate
      generator(:habichef, :HabiChef, 'Generate a HabiChef skeleton for using Habitat and Chef Policyfiles')
    end
    module GeneratorCommands
      class HabiChef < Base
        banner 'Usage: galvanize generate habichef NAME [options]'

        attr_reader :errors
        attr_reader :habichef_name_or_path

        options.merge!(SharedGeneratorOptions.options)

        def initialize(params)
          Chef::Config.send :config_context, :chefdk do
            default :generator_cookbook, File.join(Galvanize.skeletons_dir, 'habichef')
          end
          @params_valid = true
          @habichef_name = nil
          @verbose = false
          super
        end

        def run
          read_and_validate_params
          if params_valid?
            setup_context
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
          Generator.add_attr_to_context(:skip_git_init, habichef_path_in_git_repo?)
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

        def habichef_path_in_git_repo?
          Pathname.new(habichef_full_path).ascend do |dir|
            return true if File.directory?(File.join(dir.to_s, '.git'))
          end
          false
        end
      end
    end
  end
end
