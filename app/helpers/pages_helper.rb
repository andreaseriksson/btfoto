module PagesHelper
  def default_page_markup
    content_tag(:section, class: 'mainContentWrap') do
      content_tag(:div, class: 'container mainContent') do
        html = content_tag(:div, class: 'row-fluid featuredContent') do
          yield
        end
        html << content_tag(:div, class: 'row-fluid') { clearfix_markup }
        html
      end
    end
  end

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
      text = content_tag(:strong) { news.published_at.strftime("%Y-%m-%d") + " " + news.title }
      text << "<br>".html_safe
      text << news.preamble
      text << "<br>".html_safe
      text << link_to("#{t('.read_more')} #{fa 'angle-double-right'}".html_safe, news_path(news)) if news.content.present?
      text << "<hr>".html_safe
      text
    end
  end

  def index_heading(icon, text)
    content_tag(:h1) do
      "#{content_tag(:span, class: 'btn btn-inverse'){ fa(icon) }} #{text}".html_safe
    end
  end

  def clearfix_markup
    content_tag(:div, class: 'row-fluid') do
      content_tag(:div, class: 'divider dotted clearfix') { content_tag(:span) {} }
    end
  end
end
