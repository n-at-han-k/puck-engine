# frozen_string_literal: true

require_relative "lib/puck_engine/version"

Gem::Specification.new do |spec|
  spec.name        = "puck_engine"
  spec.version     = PuckEngine::VERSION
  spec.authors     = ["PuckEngine Contributors"]
  spec.email       = [""]
  spec.homepage    = "https://github.com/puckeditor/puck-engine"
  spec.summary     = "Rails engine for building sites with Puck visual editor"
  spec.description = "A mountable Rails engine that integrates Puck - the open-source visual editor for React - enabling drag-and-drop page building and site creation."
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.2"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "rails",           ">= 8.1"
  spec.add_dependency "importmap-rails"
  spec.add_dependency "stimulus-rails"
end
