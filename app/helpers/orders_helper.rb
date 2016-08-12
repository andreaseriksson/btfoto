require 'open-uri'

module OrdersHelper
  def qr_tag(content, options = {})
    size = options[:size] || 150
    src = "https://chart.googleapis.com/chart?chs=#{size}x#{size}&cht=qr&chl=#{u(content)}&choe=UTF-8"
    # image_tag src, alt: 'QR code'
    src
	end

  def embed_remote_image(url, content_type)
    asset = open(url, "r:UTF-8") { |f| f.read }
    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
