# frozen_string_literal: true

module Resolvers
  class Jobs < GraphQL::Schema::Resolver
    eager_load_model ::Job

    type [Types::Job], null: false

    def resolve
      Job.all.includes(associations_to_include)
    end
  end
end
