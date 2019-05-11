context = ChefDK::Generator.context
habitat_dir = File.join context.habichef_root, context.habichef_name

# silence_chef_formatter unless context.verbose

generator_desc 'Ensuring correct HabiChef project content'

puts "I'm heere in habichef"
