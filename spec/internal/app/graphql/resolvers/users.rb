# frozen_string_literal: true

module Resolvers
  class Users < GraphQL::Schema::Resolver
    eager_load_model ::User

    type Types::User.connection_type, null: false

    def resolve
      User.all.includes(associations_to_include)
    end
  end
end
