# frozen_string_literal: true

module PuckEngine
  class Page < ApplicationRecord
    self.table_name = "puck_engine_pages"
    
    validates :title, presence: true
    validates :slug, presence: true, uniqueness: true
    
    before_validation :generate_slug, on: :create
    
    scope :published, -> { where(published: true) }
    scope :by_slug, ->(slug) { find_by(slug: slug) }
    
    def to_param
      slug
    end
    
    private
    
    def generate_slug
      self.slug ||= title.parameterize if title.present?
    end
  end
end
