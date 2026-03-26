# frozen_string_literal: true

module PuckEngine
  class EditorController < ApplicationController
    def index
      @pages = Page.all
    end
    
    def show
      @page = Page.find(params[:id])
      @components = Component.enabled.order(:category, :name)
    end
    
    def new
      @page = Page.new
      @components = Component.enabled.order(:category, :name)
    end
    
    def create
      @page = Page.new(page_params)
      
      if @page.save
        redirect_to editor_path(@page), notice: "Page created successfully"
      else
        @components = Component.enabled.order(:category, :name)
        render :new, status: :unprocessable_entity
      end
    end
    
    def update
      @page = Page.find(params[:id])
      
      if @page.update(page_params)
        render json: { success: true, page: @page }
      else
        render json: { success: false, errors: @page.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    def destroy
      @page = Page.find(params[:id])
      @page.destroy
      
      redirect_to editor_index_path, notice: "Page deleted successfully"
    end
    
    private
    
    def page_params
      params.require(:page).permit(:title, :slug, :description, :published, :puck_data)
    end
  end
end
