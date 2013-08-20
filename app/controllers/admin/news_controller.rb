module Admin
  class NewsController < ApplicationController
    
    before_action :authenticate
    
    def index
      @news = News.all
    end
    
    def new
      @news_item = News.new
    end
    
    def create
      @news_item = News.new(news_params)
  
      if @news_item.save
        redirect_to "/admin/news", notice: 'News item was successfully created.'
      else
        render action: "new"
      end
    end
    
    private
      
    def news_params
      params.require(:news).permit(:title, :preamble, :content)
    end
    
  end
end