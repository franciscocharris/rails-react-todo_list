# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :list_id, :created_at, :updated_at

  def title
    object.name
  end
end
