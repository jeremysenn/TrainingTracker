# To change this template, choose Tools | Templates
# and open the template in the editor.

PDFKit.configure do |config|
  # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  # config.default_options = {
  #   :page_size => 'Legal',
  #   :print_media_type => true
  # }
  config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end

