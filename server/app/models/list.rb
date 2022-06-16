# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates_uniqueness_of :n_position, scope: [:user_id]
end
