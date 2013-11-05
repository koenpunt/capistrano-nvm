# Capistrano::nvm

This gem provides idiomatic [nvm](https://github.com/creationix/nvm) support for Capistrano 3.x (and 3.x
*only*).

<!-- ## Please Note

This ```capistrano-nvm``` repo is different from the current
```capistrano-nvm``` gem on rubygems.org. You **must** specify
**this github repo** in your Gemfile! -->

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano', '~> 3.0'
    gem 'capistrano-nvm', github: "koenpunt/capistrano-nvm"

And then execute:

    $ bundle --binstubs
    $ cap install

## Usage

    # Capfile

    require 'capistrano/nvm'

    set :nvm_type, :user # or :system, depends on your nvm setup
    set :nvm_node, 'v0.10.21'

If your nvm is located in some custom path, you can use `nvm_custom_path` to set it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
