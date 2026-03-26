# frozen_string_literal: true

module PuckEngine
  class Configuration
    attr_accessor :default_components, :custom_components, :authorize_editor, :layout
    
    def initialize
      @default_components = [:heading, :paragraph, :button, :card]
      @custom_components = []
      @authorize_editor = nil
      @layout = "application"
    end
  end
end
