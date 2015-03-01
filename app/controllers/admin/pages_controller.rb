module Admin
  class PagesController < ApplicationController

    before_action :authenticate_user
    respond_to :html

    def index
      @pages = Page.roots
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)

      if @page.save
        redirect_to admin_pages_path, notice: 'Page was successfully created.'
      else
        render action: "new"
      end
    end

    def edit
      @page = Page.find_by(slug: params[:id])
    end

    def update
      @page = Page.find_by(slug: params[:id])

      if @page.update_attributes(page_params)
        redirect_to admin_pages_path, notice: 'Page was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @page = Page.find_by(slug: params[:id])
      @page.destroy

      redirect_to admin_pages_path, notice: 'Page was successfully deleted.'
    end

    def move_higher
      @page = Page.find_by(slug: params[:page_id])
      @page.move_higher if @page

      redirect_to admin_pages_path, notice: 'Page was successfully deleted.'
    end

    def move_lower
      @page = Page.find_by(slug: params[:page_id])
      @page.move_lower if @page

      redirect_to admin_pages_path, notice: 'Page was successfully deleted.'
    end

    private

    def page_params
      params.require(:page).permit(:title, :content, :active, :parent_id)
    end

  end
end
