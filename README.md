# Hashlation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hashlation'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hashlation


    Hashlation::Complex -> Hashlation::Complex.new(hash) 
    
    
## Methods

The returned `obj` includes the method `.keys` to list the keys on the object at every level.

---

### Simple 

Handles simple string/symbol keys in conversion as well as singleton_methods. Very fast, but cannot handle edge cases in keys.

Usage:

`obj = Hashlation::Simple.new(hash)`


---

### Complex

Handles MOST key types in conversion. If you know that your keys will contain leading Integer characters, or ':' use this method.

Usage:

`obj = Hashlation::Complex.new(hash)`

---

**If `Complex` fails due to inability to read key, please report in Issues. Thanks! **

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rharris389/hashlation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
