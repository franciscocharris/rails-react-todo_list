# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user

  validates :description, presence: true
  validates :list_id, presence: true
  validates :name, presence: true,
                   format: {
                     with: /\A[a-zA-Z0-9- ]+\z/,
                     message: 'the name has specials characters'
                   }
end
