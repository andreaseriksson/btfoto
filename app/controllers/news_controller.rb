class NewsController < ApplicationController

  before_action :load_menu

  layout 'frontend'

  def index
    @news = News.published.paginate(page: params[:page], per_page: 20)
  end

  def show
    @page = Page.first
    @news = News.find_by(slug: params[:id])
    redirect_to root_path unless @news
  end

  private

  def load_menu
    @pages = Page.roots.where(active: true)
  end
end
