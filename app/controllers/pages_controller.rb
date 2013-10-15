class PagesController < ApplicationController
  layout 'frontend'
  
  before_action :load_menu
  
  def index
    @frontpage = Frontpage.new
  end
  
  def show
    if params[:id]
      @page = Page.find_by(slug: params[:id])
      redirect_to root_path unless @page
    else
      @page = Page.first
    end
    
    redirect_to root_path if @page == Page.first
  end
  
  def redirect
    redirect_to root_path, :status => :moved_permanently
  end
    
  private
  
  def load_menu 
    @pages = Page.roots.where(active: true)   
  end
end
