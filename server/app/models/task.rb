class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user
  validates :name, :description, :list_id, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9- ]+\z/, message: 'the name has specials characters' }
end
