module PagesHelper
  
  def page_markup(content)
    
    content_tag :section, class: 'mainContentWrap' do
      content_tag :div, class: 'container mainContent' do
        content_tag :div, class: 'row-fluid' do
          content_tag :div, class: 'span12' do
            content = content_tag(:div, class: 'row-fluid featuredContent') { content }
            content << content_tag(:div, class: 'divider dotted clearfix') { content_tag(:span) }
            content.html_safe
          end
        end
      end
    end

  end
  
end