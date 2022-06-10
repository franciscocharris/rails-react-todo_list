# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :cards, dependent: :destroy
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  before_save { self.email = self.email.downcase.delete(' ') }

  @@cards_data = [
    { name: 'To Do', n_position: 1 },
    { name: 'Doing', n_position: 2 },
    { name: 'Done', n_position: 3 }
  ]

  def create_default_cards
    @@cards_data.each do |card|
      Card.create(name: card[:name], n_position: card[:n_position], user: self)
    end
  end
end
