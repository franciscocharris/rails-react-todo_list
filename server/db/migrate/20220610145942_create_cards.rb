# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :n_position
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
