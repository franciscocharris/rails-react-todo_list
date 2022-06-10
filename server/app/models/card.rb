class Card < ApplicationRecord
  belongs_to :user
  validates :name, :n_position, presence: true
  validates_uniqueness_of :n_position, scope: [:user_id]
end
