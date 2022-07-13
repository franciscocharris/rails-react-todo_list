# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :n_position, presence: true,
                         numericality: { only_integer: true }
  validates_uniqueness_of :n_position, scope: [:user_id]
end
