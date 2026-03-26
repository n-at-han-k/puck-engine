# frozen_string_literal: true

require "rails/generators"
require "rails/generators/migration"

module PuckEngine
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path("templates", __dir__)
      
      desc "Installs PuckEngine with migrations and initial setup"
      
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
      def create_migrations
        migration_template "create_puck_engine_pages.rb", 
                          "db/migrate/create_puck_engine_pages.rb"
        migration_template "create_puck_engine_components.rb", 
                          "db/migrate/create_puck_engine_components.rb"
      end
      
      def copy_initializer
        template "puck_engine.rb", "config/initializers/puck_engine.rb"
      end
      
      def show_readme
        readme "README" if behavior == :invoke
      end
      
      private
      
      def migration_template(source, destination, config = {})
        destination = File.join(destination_root, destination)
        
        # Check if migration already exists
        if migration_exists?(destination)
          say_status "skipped", "Migration #{destination} already exists"
          return
        end
        
        # Create migration with timestamp
        migration_dir = File.dirname(destination)
        migration_file = File.basename(destination)
        timestamped_file = "#{next_migration_number(migration_dir)}_#{migration_file}"
        destination = File.join(migration_dir, timestamped_file)
        
        template(source, destination, config)
      end
      
      def migration_exists?(destination)
        migration_dir = File.dirname(destination)
        migration_file = File.basename(destination, ".rb")
        
        return false unless File.exist?(migration_dir)
        
        Dir.glob(File.join(migration_dir, "*.rb")).any? do |file|
          File.basename(file, ".rb").end_with?("_#{migration_file}")
        end
      end
    end
  end
end
