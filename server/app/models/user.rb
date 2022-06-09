# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  before_save { self.email = self.email.downcase.delete(' ') }
end
