# frozen_string_literal: true

module PuckEngine
  class ComponentsController < ApplicationController
    def index
      @components = Component.enabled.order(:category, :name)
      
      respond_to do |format|
        format.json { render json: @components }
      end
    end
    
    def show
      @component = Component.find(params[:id])
      
      respond_to do |format|
        format.json { render json: @component }
      end
    end
  end
end
