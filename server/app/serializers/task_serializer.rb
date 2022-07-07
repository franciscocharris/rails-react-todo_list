# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :list_id, :created_at, :updated_at
end
