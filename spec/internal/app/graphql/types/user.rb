# frozen_string_literal: true

module Types
  class User < GraphQL::Schema::Object
    field :id, ID, null: false
    field :jobs, [Job], null: false
    field :proposal_documents, [ProposalDocument], null: false
    field :order, Order, null: false

    def order
      { code: SecureRandom.uuid }
    end
  end
end
