# Ddoc

Generate dynamic documentation *WIP* - Still very much work in progress.
Documents your methods as you run your code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ddoc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ddoc

## Usage

Add `Ddoc.document! self` to the _bottom_ of the class you want to document, 
just before the closing end.
```ruby
class SomeClass
  ...
  Ddoc.document! self
end
```
Ddoc will add comments to files noting what arguments methods are called with,
where they were called from, and what they returned.

Ddoc.document! defaults to adding documentation to the file it's called in. 
Pass a second parameter to specify a different output file.
`Ddoc.document! self, 'outputfile.ddoc.rb'`  

TODO:

[ ] - Test with Rails  
[ ] - Add better spec coverage
[ ] - Add more info to the default document generator

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[rjlynch]/ddoc.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
