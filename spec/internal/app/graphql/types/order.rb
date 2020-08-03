# frozen_string_literal: true

module Types
  class Order < GraphQL::Schema::Object
    field :code, ID, null: false
  end
end
