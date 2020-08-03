# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table(:users, force: true) do |t|
    t.string :email
    t.timestamps
  end

  create_table(:jobs, force: true) do |t|
    t.references :user
    t.timestamps
  end

  create_table(:proposal_documents, force: true) do |t|
    t.references :user
    t.timestamps
  end
end
