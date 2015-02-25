class Frontpage
  def news
    News.published.limit(5)
  end

  def gallery
    Gallery.all
  end

  def page
    Page.first
  end
end
