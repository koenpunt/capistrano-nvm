# Capistrano::nvm

[nvm](https://github.com/creationix/nvm) support for Capistrano 3.x

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.1'
gem 'capistrano-nvm', require: false
```

And then execute:

    $ bundle install

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/nvm'
```

Configurable options:

```ruby
set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v0.10.21'
set :nvm_map_bins, %w{node npm yarn}
```

If your nvm is located in some custom path, you can use `nvm_custom_path` to set it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
