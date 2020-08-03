# frozen_string_literal: true

module Types
  class QueryType < GraphQL::Schema::Object
    field :jobs, null: false, resolver: Resolvers::Jobs
    field :users, null: false, resolver: Resolvers::Users
  end
end
