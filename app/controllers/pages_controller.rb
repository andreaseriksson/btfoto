class PagesController < ApplicationController

  before_action :load_menu

  layout 'frontend'

  def index
    @frontpage = Frontpage.new
  end

  def show
    if params[:id]
      @page = Page.find_by(slug: params[:id])
      return redirect_to(root_path) unless @page
    else
      @page = Page.first
    end

    return redirect_to(root_path) if @page.nil? || @page.first_page?
  end

  def redirect
    redirect_to root_path, status: :moved_permanently
  end

  private

  def load_menu
    @pages = Page.roots.where(active: true)
  end
end
