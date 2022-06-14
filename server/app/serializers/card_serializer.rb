# frozen_string_literal: true

class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :n_position
  belongs_to :user
end
