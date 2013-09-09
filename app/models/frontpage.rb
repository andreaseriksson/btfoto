class Frontpage
  def news
    News.where("published_at <= ?", Time.new.strftime("%Y-%m-%d")).limit(5).order("published_at desc")
  end
  
  def gallery
    Gallery.all
  end
  
  def page
    Page.first
  end
end