# frozen_string_literal: true

class InternalSchema < GraphQL::Schema
  query(Types::QueryType)
end
