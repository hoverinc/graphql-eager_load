# frozen_string_literal: true

class ProposalDocument < ActiveRecord::Base
  belongs_to :user
end
