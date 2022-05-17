# Hashlation

FAST and VERSATILE hash transformer. Born of the need to more easily read and traverse deeply nested response objects. Faster at 1 to 1 comparisons and more versatile than both OpenStruct and Hashie.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hashlation'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hashlation


    
    
## Usage

The returned `obj` includes the method `.keys` to list the keys on the object at every level.

`obj = Hashlation::Any.new(hash)`

Handles both simple and complex string/symbol keys in translation. Defines singleton_methods for keys ending in '?'.

---

## Translated Keys Format:

Keys that cannot be set as-is by attr_accessor will be transformed. For example:

- `'Test-Name' -> obj.test_name`

- `'11123:12312' -> obj._11123_12312`

** If `Any` fails due to inability to read a key, please report in GitHub Issues. Thanks! **

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rharris389/hashlation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---

*Naming credit belongs to my wife, who bales out my inability to name stuff..*