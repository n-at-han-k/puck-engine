# frozen_string_literal: true

module PuckEngine
  module ApplicationHelper
    # Render a Puck page
    def puck_render_page(page)
      return unless page.is_a?(Page)
      
      content_tag(:div, 
        id: "puck-render-root",
        data: {
          controller: "puck-render",
          puck_render_target: "root",
          page_data: page.puck_data.to_json
        }
      ) do
        # The actual rendering happens via JavaScript
        content_tag(:div, "Loading page...", class: "puck-loading")
      end
    end
    
    # Link to the Puck editor
    def puck_editor_link(text = "Edit with Puck", options = {})
      link_to text, puck_engine.editor_index_path, options
    end
    
    # Link to a specific page in the editor
    def puck_edit_page_link(page, text = "Edit", options = {})
      return unless page.is_a?(Page)
      link_to text, puck_engine.editor_path(page), options
    end
    
    # Link to view a page
    def puck_view_page_link(page, text = "View", options = {})
      return unless page.is_a?(Page)
      link_to text, puck_engine.page_path(page), options
    end
    
    # Check if user can edit
    def puck_can_edit?
      return true unless PuckEngine.config.authorize_editor
      
      if respond_to?(:current_user)
        PuckEngine.config.authorize_editor.call(current_user)
      else
        false
      end
    end
  end
end
