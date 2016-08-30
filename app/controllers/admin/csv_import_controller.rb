require 'net/http'
require 'uri'
require 'csv'

module Admin
  class CsvImportController < ApplicationController
    def index
    end

    def preview
      uri = params[:csv_import]
      return unless uri

      @filename = uri.split('/').last
      page_content = open(uri)

      tempfile = Tempfile.new(@filename, encoding: 'ascii-8bit')
      tempfile.write page_content
      tempfile.close

      @imports = []
      delimiter = find_delimiter(tempfile)
      CSV.foreach(tempfile, headers: true, col_sep: delimiter) do |row|
        @imports << OpenStruct.new(email: row['email'], image: row['image'])
      end

      images = @imports.map(&:image)
      @pictures = Picture.where(image: images).pluck(:image)
    end

    def import
      imports = params[:imports] || []
      imports.each do |import|
        email, image = import.split('|')
        ImportMailer.delay.notification(email, image)
      end
    end

    private

    def open(url)
      Net::HTTP.get(URI.parse(url))
    end

    def find_delimiter(tempfile)
      result = CSV.read(tempfile)&.flatten || []
      %w(; , |).find { |delimiter| result.first.include? delimiter } || ','
    end
  end
end
