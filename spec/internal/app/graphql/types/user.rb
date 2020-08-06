# frozen_string_literal: true

module Types
  class User < GraphQL::Schema::Object
    field :id, ID, null: false
    field :jobs, [Job], null: false
    field :proposal_documents, [ProposalDocument], null: false
    field :order, Order, null: false
    field :photo, Types::File, null: true

    def order
      { code: SecureRandom.uuid }
    end

    def photo
      object.photo if object.photo.attached?
    end

    def self.allow_include_builder_fields
      [:photo]
    end
  end
end
