# frozen_string_literal: true

class CreatePuckEnginePages < ActiveRecord::Migration[8.1]
  def change
    create_table :puck_engine_pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.boolean :published, default: false
      t.jsonb :puck_data, default: {}
      
      t.timestamps
    end
    
    add_index :puck_engine_pages, :slug, unique: true
    add_index :puck_engine_pages, :published
  end
end
