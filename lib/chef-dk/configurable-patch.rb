require 'chef/config'

# ensure our default generator cookbook is relative to _THIS_ file
# We need to require this file last.
#
# would be nice to just include the one file and let the default use the embedded cookbook...
# I'm thinking have:
#   galvanize/lib/chef-dk/skeleton/generator_cookbook/
# Include just the metadata, recipe, and relevant templates for the `habichef` command.

class Chef::Config
  config_context(:chefdk) do
    default(:generator_cookbook, File.expand_path('../skeletons/code_generator', __FILE__))
  end
end
