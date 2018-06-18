# Ddoc

Generate dynamic documentation *WIP* - Still very much work in progress.  
Documents your methods as you run your code.

## Installation

Add this line to your application's Gemfile:  
`gem 'ddoc', git: 'git@github.com:rjlynch/ddoc.git'`

Then require ddoc  
`require 'ddoc'`

## Usage

Add `Ddoc.document! self` to the _bottom_ of the class you want to document, 
just before the closing end.
```ruby
class SomeClass
  def instance_method_with_args(*args)
    return *args
  end

  Ddoc.document! self
end
```
Ddoc will add comments to files noting what arguments methods are called with,
where they were called from, and what they returned.
```ruby
  ...
  # spec/ddoc_spec.rb
  expect(SomeClass.new.instance_method_with_args(7)).to eq [7] #=> true
  ...
```

```ruby
class SomeClass
  # DDOC 2018-06-17
  # @param  [Integer] args Example 7
  # @return [Array] Example [7]
  # @caller [/Users/richardlynch/Development/ddoc/spec/ddoc_spec.rb:23:in `block (3 levels) in <top (required)>']
  def instance_method_with_args(*args)
    return *args
  end

  Ddoc.document! self
end
```

Ddoc.document! defaults to adding documentation to the file it's called in. 
Pass a second parameter to specify a different output file.
`Ddoc.document! self, 'outputfile.ddoc.rb'`  

TODO:

[ ] - Test with Rails  
[ ] - Add better spec coverage  
[ ] - Expand array types in documentation  
[ ] - Add more info to the default document generator

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[rjlynch]/ddoc.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
