# frozen_string_literal: true

module Types
  class Job < GraphQL::Schema::Object
    field :id, ID, null: false
    field :user, User, null: true
  end
end
