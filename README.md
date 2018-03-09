# Capistrano::nvm

[nvm](https://github.com/creationix/nvm) support for Capistrano 3.x

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.1'
gem 'capistrano-nvm', require: false, github: 'BuyerQuest/capistrano-nvm'
```

And then execute:

```shell
$ bundle install
```

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/nvm'
```

The task then uses command maps to run `nvm.sh` when necessary, as controlled by the setting `:nvm_map_bins`.

## Configuration

### Settings

In your capistrano `config/deploy.rb`:

#### Required

- `:nvm_node`
  - Accepts: String
  - Default: None
  - Notes: The version number must be prefixed with a `v` if `:nvm_verb` is set to `:use`. See examples below.

#### Optional

- `:nvm_type`
  - Accepts: `:user`, `:system`
  - Default: `:user`
  - Notes: Used to determine the location of `nvm.sh`, similar to setting `$NVM_HOME` in your shell.

- `:nvm_custom_path`
  - Accepts: String
  - Default: Unused
  - Notes: Setting this effectively overrides `:nvm_type`.

- `:nvm_map_bins`
  - Accepts: Ruby word array
  - Default: `%w{node npm yarn}`
  - Notes: This is a list of commands that will be executed with NVM support by capistrano.

- `:nvm_verb`
  - Accepts: `:use`, `:install`
  - Default: `:use`
  - Notes: Determines whether the deploy invokes `nvm use` or `nvm install`.

## Examples

### Configuring Capistrano

Using a version of NodeJS that is already installed and managed by NVM:

```ruby
set :nvm_node, 'v8.10' # Version of node.js to use with NVM
```

Using a version of NodeJS that we want to download and install:

```ruby
set :nvm_node, 'lts/carbon' # Friendly names work well...
set :nvm_verb, 'install' # ...but only with the "install" verb
```

When NVM is installed at the system level:

```ruby
set :nvm_node, 'lts'
set :nvm_verb, 'install'
set :nvm_type, :system
```

When NVM is installed in a custom location:

```ruby
set :nvm_node, 'lts'
set :nvm_verb, 'install'
set :nvm_custom_path, '/usr/local/src/nvm' # This overrides :nvm_type so we won't bother setting it
```

### Using a .nvmrc file

#### In your Capistrano code

In `config/deploy.rb`, check for `.nvmrc` and use its value, or a sensible default like v8.10:

```ruby
set :nvm_node, File.exist?('.nvmrc') ? File.read('.nvmrc').strip : "v8.10"
```

#### From your release code

In your rakefile where you `execute :npm`, `:node`, or `:yarn`, add this conditional first:

```ruby
if test "[ -e #{release_path}/.nvmrc ]"
  download! "#{release_path}/.nvmrc", '.nvmrc'
  SSHKit.config.default_env[:node_version] = File.read('.nvmrc').strip
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
