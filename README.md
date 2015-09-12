# Subroutine::Factory

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'subroutine-factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subroutine-factory

## Usage

The Subroutine gem does a great job of encapsulating your app's business logic. To simplify the usage of Subroutine Ops in your test suite, utilize the subroutine-factory gem.

Defining factories:

```ruby
Subroutine::Factory.define :signup do
  op ::SignupOp

  inputs :email, sequence{|n| "foo{n}@example.com" }
  inputs :password, "password123"

  # by default, the op will be returned when the factory is used.
  # this `output` returns the value of the accessor on the resulting op
  output :user
end

Subroutine::Factory.define :business_signup do

  # all configurations are inherited from the "signup" factory
  parent :signup

  op ::BusinessSignupOp

  input :business_name, sequence{|n| "Business #{n}" }

  # you can output multiple things into a hash by using `outputs`
  outputs :user, :business
end
```

Using Factories:

```ruby
user = Subroutine::Factory.create :signup
user = Subroutine::Factory.create :signup, email: "foo@bar.com"

out = Subroutine::Factory.create :business_signup
out[:user] #=> User{}
out[:business] #=> Business{}
```

Spec / Test Helper:
```ruby
#spec_helper.rb, test_helper.rb
config.include ::Subroutine::Factory::SpecHelper

# in your tests
user = factory(:signup)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mnelson/subroutine-factory.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
