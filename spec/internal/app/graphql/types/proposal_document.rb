# frozen_string_literal: true

module Types
  class ProposalDocument < GraphQL::Schema::Object
    field :id, ID, null: false
    field :user, User, null: true
  end
end
