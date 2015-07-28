# Depend

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/depend`. To experiment with that code, run `bin/console` for an interactive prompt.

With Depend, you can handle native dependent more easily

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'depend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install depend

## Usage

```ruby
class YourGem::Depend < Depend::Base
  def mac_os_x
    case package_provider
    when 'homebrew'
      %w{mysql-dev}
    when 'macports'
      %w{mysql-dev}
    end
  end

  def ubuntu
    %w{mysql-dev}
  end

  def fedora
    %w{mysql-devel}
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/depend/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
