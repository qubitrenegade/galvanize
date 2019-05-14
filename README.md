[![Gem Version](https://badge.fury.io/rb/galvanize.svg)](https://badge.fury.io/rb/galvanize)

# Galvanize

This gem bundles some monkey-patching to extend the default ChefDK Generator (`chef generate`) and a wrapper script (`galvanize`) that includes the correct files before invoking `ChefDK::CLI.new().run`, which is dumb...  there's got to be a way to include this gem, i.e. from the `knife.rb`, but I couldn't figure it out.  So until such time as I figure a better way, settling for `galvanize generate`.

## Justification

I want to write a cookbook for a project template.

First I created [chef-skeleton](https://github.com/qubitrenegade/habichef-skeleton), the "clone, change variables, then add content" workflow is better than creating a project skeleton from scratch every time... but only just barely.  Then I created [habichef_generator](https://github.com/qubitrenegade/habichef_generator_demo) cookbook.  Running `chef generate cookbook habichef_name -g habichef_generator_cookbook` is just... awkward.  And I don't have control over the variables as I'd like.  Also, running a similar cookbook with chef in local mode doesn't work without sudo and then you need to manually `sudo chown myuser:myuser my_new_project`.  [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) is an interesting project, but trying to support python tools in a Ruby/Chef development toolchain has been problematic and poltically challenging.  And Finally, I really like the idea of "Cookbook as project template".  We already use Chef for everything, so why not project templates too?

This project leverages all of the great work by the folks at Chef and extends the abilities of the generator.

## Installation

This should be installable as:

    $ chef gem install galvanize

## Usage

Once installed, the `galvanize` (or `gal`) command effectively replaces the `chef` command.  Refer to the [ChefDK Docs](https://github.com/chef/chef-dk/blob/master/README.md) for full ChefDK usage instructions.

The following documents the additions.

### Additional Generators

#### HabiChef

```bash
gal generate habichef <name> [options]
```

This generates a basic HabiChef skeleton.  Based on [habichef-skeleton](https://github.com/qubitrenegade/habichef-skeleton) project.

#### Terraform

Coming Soon...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Things todo/Help Wanted

* [ ] #1: How to load custom `code_generator` for only new generators.
* [ ] #2: Terraform Generator.
* [ ] #3: NodeJS project generator.
* [ ] #4: Implications of `chef-dk` as a gem dep.
* [ ] #5/#6: TESTS!  Wow...  tsk tsk.  No tests...
* [ ] #9: CI Setup (TravisCI? or?)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qubitrenegade/galvanize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Galvanize project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/qubitrenegade/galvanize/blob/master/CODE_OF_CONDUCT.md).
