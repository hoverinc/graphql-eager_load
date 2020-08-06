# Graphql::Eager::Loader

This gem traverses your graphql query looking for fields on types that match
associations on those types. For each field found to be an association, this
gem adds those associations to an [ActiveRecord::QueryMethods#includes](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-includes) hash. That hash can then be used to 
eager load the associations of records returned in your graphql resolver. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql-eager)loader', git: 'https://github.com/hoverinc/graphql-eager)loader'
```

And then execute:

    $ bundle install

## Usage

```ruby
module Resolvers
  class Users < Resolvers::Base
    eager_load_model ::User
    
    type Types::User.connection_type, null: false

    def resolve
      User.active.includes(associations_to_eager_load)
    end
  end
end
```

The `.eager_load_model` and `#associations_to_eager_load` methods are provided by this gem. 

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bundle exec bin/console` for an interactive prompt that will allow you to experiment.

To release a new version:

- Update the version number in `version.rb`
- Make a PR with your changes and the version number increment
- After the PR is merged, make the new release https://github.com/hoverinc/graphql-eager-loader/releases

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hoverinc/graphql-eager-loader.


## License

HOVER owns it. Ask Legal. 
