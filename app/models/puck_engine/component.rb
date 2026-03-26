# frozen_string_literal: true

module PuckEngine
  class Component < ApplicationRecord
    self.table_name = "puck_engine_components"
    
    validates :name, presence: true, uniqueness: true
    validates :category, presence: true
    
    scope :by_category, ->(category) { where(category: category) }
    scope :enabled, -> { where(enabled: true) }
    
    def self.categories
      distinct.pluck(:category)
    end
  end
end
