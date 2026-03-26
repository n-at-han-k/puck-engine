# frozen_string_literal: true

module PuckEngine
  class PagesController < ApplicationController
    def index
      @pages = Page.published
    end
    
    def show
      @page = Page.find(params[:id])
      
      if @page.published? || params[:preview]
        render :show
      else
        redirect_to root_path, alert: "Page not found"
      end
    end
    
    def by_slug
      @page = Page.published.find_by!(slug: params[:slug])
      render :show
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Page not found"
    end
  end
end
