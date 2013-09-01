class Frontpage
  def news
    News.limit(5).order("id desc")
  end
  
  def gallery
    Gallery.all
  end
  
  def page
    Page.first
  end
end