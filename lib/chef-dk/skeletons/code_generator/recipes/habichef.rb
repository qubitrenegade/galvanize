context = ChefDK::Generator.context
habitat_dir = File.join context.habichef_root, context.habichef_name

# silence_chef_formatter unless context.verbose

generator_desc 'Ensuring correct HabiChef project content'

spdx_license =  case context.license
                when 'apachev2'
                  'Apache-2.0'
                when 'mit'
                  'MIT'
                when 'gplv2'
                  'GPL-2.0'
                when 'gplv3'
                  'GPL-3.0'
                else
                  'All Rights Reserved'
                end

# cookbook root dir
directory habitat_dir
# rest of dirs
%w(habitat policyfiles).each do |dir|
  directory File.join habitat_dir, dir
end

# our base files
%w(
  habitat/default.toml
  habitat/plan.sh
  habitat/README.md
  policyfiles/base.rb
).each do |name|
  template File.join habitat_dir, name do
    helpers(ChefDK::Generator::TemplateHelper)
    source "#{name}.erb"
    action :create_if_missing
  end
end

# LICENSE
template "#{habitat_dir}/LICENSE" do
  helpers(ChefDK::Generator::TemplateHelper)
  source "LICENSE.#{context.license}.erb"
  action :create_if_missing
end

# CHANGELOG
template "#{habitat_dir}/CHANGELOG.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Inspec
directory "#{habitat_dir}/test/integration/default" do
  recursive true
end

template "#{habitat_dir}/test/integration/default/default_test.rb" do
  source 'inspec_default_test.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# git
if context.have_git
  unless context.skip_git_init
    generator_desc('Committing cookbook files to git')

    execute('initialize-git') do
      command('git init .')
      cwd habitat_dir
    end
  end

  template "#{habitat_dir}/.gitignore" do
    source 'gitignore'
  end

  unless context.skip_git_init
    execute('git-add-new-files') do
      command('git add .')
      cwd habitat_dir
    end

    execute('git-commit-new-files') do
      command('git commit -m "Add generated HabiChef content"')
      cwd habitat_dir
    end
  end
end
