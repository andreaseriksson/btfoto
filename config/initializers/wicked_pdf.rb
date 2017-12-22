if Rails.env == 'production'
  WickedPdf.config = {
    :exe_path => '/app/wkhtmltopdf'
  }
end
