# frozen_string_literal: true

class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :n_position
  has_many :tasks
end
