# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :lists, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  before_save { self.email = email.downcase.delete(' ') }
  after_save :create_default_lists

  LISTS_DATA = [
    { name: 'To Do', n_position: 1 },
    { name: 'Doing', n_position: 2 },
    { name: 'Done', n_position: 3 }
  ].freeze

  def create_default_lists
    LISTS_DATA.each do |list|
      List.create(name: list[:name], n_position: list[:n_position], user: self)
    end
  end

  scope :get_list, -> { lists }
end
