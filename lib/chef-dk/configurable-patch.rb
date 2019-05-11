require 'chef/config'

class Chef::Config
  config_context(:chefdk) do
    default(:generator_cookbook, File.expand_path('../skeletons/code_generator', __FILE__))
  end
end
