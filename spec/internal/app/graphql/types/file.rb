# frozen_string_literal: true

module Types
  class File < GraphQL::Schema::Object
    field :filename, String, null: false
  end
end
