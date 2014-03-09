module PagesHelper
  
  def page_markup(content)
    content_tag :section, class: 'mainContentWrap' do
      content_tag :div, class: 'container mainContent' do
        content_tag :div, class: 'row-fluid' do
          content_tag :div, class: 'span12' do
            content = content_tag(:div, class: 'row-fluid featuredContent') { content }
            content << content_tag(:div, class: 'divider dotted clearfix') { content_tag(:span) }
            content
          end
        end
      end
    end
  end
  
  def news_item(news)
    content_tag(:p) do   
      text = content_tag(:strong) { news.published_at.strftime("%Y-%m-%d") }
      text << link_to(news.title, news_path(news))
      text << "<br>".html_safe
      text << link_to(news.preamble, news_path(news))
      text.html_safe
    end
  end
end