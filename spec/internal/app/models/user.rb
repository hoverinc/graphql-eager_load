# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :jobs
  has_many :proposal_documents

  has_one_attached :photo
end
