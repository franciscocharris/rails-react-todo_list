# frozen_string_literal: true

class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :n_position
  belongs_to :user
end
