# frozen_string_literal: true

class Job < ActiveRecord::Base
  belongs_to :user
end
