# Graphql::EagerLoad

This gem assumes you are using [Rails](http://rubyonrails.org) and [ActiveRecord](https://guides.rubyonrails.org/active_record_querying.html). And that your GraphQL types and fields map as closely to your data model as possible. It uses those assumptions, or conventions, to handle a N+1 prevention for you.

It does so by traversing your graphql query looking for fields on types that match
associations on those types' corresponding models. For each field found to be an association, this
gem adds those associations to an [ActiveRecord::QueryMethods#includes](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-includes) hash. That hash can then be used to
eager load the associations of records returned in your graphql resolver.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql-eager_load'
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


If your type defines a custom method for a field that maps to an ActiveRecord association, this gem will ignore that association and let your method handle it. If you still want to eager load the association in that case you need to let the gem know.

```ruby
module Types
  class User < Types::Base
    field :estimates, [Types::Estimate], null: false
    field :profile_photo, Types::File, null: true
    
    def profile_photo
      object.profile_photo if object.profile_photo.attached?
    end
    
    def self.allow_include_builder_fields
      [:profile_photo]
    end
  end
end
```

Given this query: 

```javascript
users {
  id
  estimates {
    id
  }
  profilePhoto {
    redirectUrl
    filename
  }
}
```

The output of the `#associations_to_eager_load` helper method would be `{estimates: {}, profile_photo: {blob: {}}`. Without the `.allow_include_builder_fields` class method the output would be `{estimates: {}}`.

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bundle exec bin/console` for an interactive prompt that will allow you to experiment.

To release a new version:

- Update the version number in `version.rb`
- Make a PR with your changes and the version number increment
- After the PR is merged, make the new release https://github.com/hoverinc/graphql-eager-load/releases

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hoverinc/graphql-eager-load.


## License

MIT
