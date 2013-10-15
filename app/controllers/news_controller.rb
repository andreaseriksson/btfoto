class NewsController < ApplicationController
  layout 'frontend'
  
  before_action :load_menu
  
  def index
    @news = News.where("published_at <= ?", Time.new.strftime("%Y-%m-%d")).order("published_at desc").paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    if params[:id]
      @page = Page.find_by(slug: params[:id])
      redirect_to root_path unless @page
    else
      @page = Page.first
    end
    
  end
  
  private
  
  def load_menu 
    @pages = Page.roots.where(active: true)   
  end
end