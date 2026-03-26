# frozen_string_literal: true

class CreatePuckEngineComponents < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    create_table :puck_engine_components do |t|
      t.string :name, null: false
      t.string :category, null: false, default: "General"
      t.text :description
      t.jsonb :fields, default: {}
      t.jsonb :default_props, default: {}
      t.boolean :enabled, default: true
      t.text :render_code
      
      t.timestamps
    end
    
    add_index :puck_engine_components, :name, unique: true
    add_index :puck_engine_components, :category
    add_index :puck_engine_components, :enabled
  end
end
