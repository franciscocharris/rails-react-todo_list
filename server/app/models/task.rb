class Task < ApplicationRecord
  belongs_to :list
  validates :name, :description, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9-]+\z/, message: 'the name has specials characters' }
end
