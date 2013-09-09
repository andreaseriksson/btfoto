module Admin
  class NewsController < ApplicationController
    
    before_action :authenticate_user
    
    def index
      @news = News.all
    end
    
    def new
      @news_item = News.new
    end
    
    def create
      @news_item = News.new(news_params)
  
      if @news_item.save
        redirect_to admin_news_index_path, notice: 'News item was successfully created.'
      else
        render action: "new"
      end
    end
    
    def edit
      @news_item = News.find_by(slug: params[:id])
    end
    
    def update
      @news_item = News.find_by(slug: params[:id])
  
      if @news_item.update_attributes(news_params)
        redirect_to admin_news_index_path, notice: 'News was successfully updated.'
      else
        render action: "edit"
      end
    end
    
    def destroy
      @news_item = News.find_by(slug: params[:id])
      @news_item.destroy
      
      redirect_to admin_news_index_path, :notice => 'News was successfully deleted.'
    end
    
    private
      
    def news_params
      params.require(:news).permit(:title, :preamble, :content, :published_at)
    end
    
  end
end