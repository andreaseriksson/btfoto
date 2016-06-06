module StoreHelper
  def store_page_markup(partials)
    # Worst markup ever!
    content_tag(:section, class: 'mainContentWrap') do
      content_tag(:div, class: 'container mainContent') do
        content_tag(:div, class: 'row-fluid') do
          html = content_tag(:div, class: 'span9') do
            content_tag(:div, class: 'row_fluid') do
              content_tag(:div, class: 'innerSpacer') do
                content_tag(:div, class: 'contentWrap') do
                  yield
                end
              end
            end
          end
          html << content_tag(:aside, class: 'span3 sidebar') do
            partials.map { |partial| render partial }.join.html_safe
          end
          html
        end
      end
    end
  end

  def heading_for product
    content_tag(:h2) do
      "#{product.name} <span class='pull-right'>#{extra_price(product)} Kr</span>".html_safe
    end
  end

  def is_freight_free_text
    if @cart.days_left >= 0
      sum = @cart.summary[:sum_after_discount]
    else
      sum = @cart.summary[:sum_without_delivery]
    end

    diff = Order::FREIGHT_FREE - sum

    if sum < Order::FREIGHT_FREE
      t('store.cart.sum_until_freight_free', sum: to_curr(diff)).html_safe
    else
      t 'store.cart.freight_free'
    end
  end

  def sybling_picture(picture)
    chosen = picture.id == @picture.id ? 'chosen' : ''
    btn_class = picture.id == @picture.id ? 'btn-danger' : ''

    content_tag(:div, class: "span6 thumbnail #{chosen}") do
      html = content_tag(:div, class: 'img-modal') { thumbnail(picture, picture.image.url ) }
      html << link_to((picture.id == @picture.id ? 'Vald!':'Välj'),
                      store_switch_image_path(image_nr: picture.image_nr),
                      class: "btn-block btn btn-small #{btn_class}" )
      html
    end
  end

  def displayed?
    'display: none;' unless @cart.summary.to_json.downcase.include? 'skolkatalog'
  end
end
