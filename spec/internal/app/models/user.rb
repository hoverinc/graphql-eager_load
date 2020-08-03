# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :jobs
  has_many :proposal_documents
end
