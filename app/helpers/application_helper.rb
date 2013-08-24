module ApplicationHelper
  
  def cart_summary(cart)
    number_to_currency(150, locale: :se, unit: " ")
  end
  
  def price
    
  end
  
  def to_curr(num)
    number_to_currency(num, locale: :se, unit: "")
  end
  
  def is_active?(page_name)
    if page_name == 'startsida' and params[:controller] == 'pages' and params[:action] == 'index'
      "active"
    elsif params[:controller] == page_name or (page_name == 'store' and params[:controller] == 'orders')
      "active"
    elsif params[:id] == page_name
      "active"
    end    
  end
  
  def flash_message(name,msg)
    if name == :notice 
			title = t('Success')
			theme = 'blue'
      sticky = 'false'
		else
			title = t('Failure')
			theme = 'red'
			sticky = 'true'
		end
    
    msgs = "$.jGrowl('#{msg}', {header: '#{title}', sticky: #{sticky}, theme: '#{theme}'});"
    content_tag :script , raw("$(document).ready(function() { #{msgs} });") , :type => "text/javascript"
  end
  
  def pdf_image_tag(image, options={})
    image_path = "file:///#{File.expand_path(Rails.root)}/public#{image}"
    #image_path
    image_tag image_path, class: 'thumbnail'
    
  end
  
  def thumbnail(picture,url)
    link_to image_tag(picture.image), url, class: 'display', data: {toggle: "tooltip", placement: "top"}, title: picture.image_nr
  end
  
  def display_gallery content
    if content.length > 0
      content
    end
  end
  
  def display_tagline content
    if content.length > 0
      content_tag(:section, class: "taglineWrap") do
        content_tag(:div, class: "container") do
          content_tag(:div, class: "row welcome_inner") do     
            content_tag(:div, class: "span12") { content }
          end
        end
      end
    end
  end
  
end
