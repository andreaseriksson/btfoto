class Categorization < ActiveRecord::Base
  belongs_to :product_category
  belongs_to :product
end
