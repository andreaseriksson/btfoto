module Sortable
  extend ActiveSupport::Concern
  
  included do
      
  end
  
  def move_lower
    self.update_attribute :position_position, :last
  end
  
  def move_higher
    self.update_attribute :position_position, :first
  end
  
end