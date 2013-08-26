class Appointment < ActiveRecord::Base
  validates :label, presence: true
  validates :start_time, presence: true
  validate :start_time_is_valid_datetime
  validate :start_time_is_at_least_today
  
  private
  
  def start_time_is_valid_datetime
    if !start_time.is_a?(Time)
     errors.add(:start_time, 'must be a valid date') 
    end
  end
  
  def start_time_is_at_least_today
    if start_time.is_a?(Time) && Date.today > start_time
      errors.add(:start_time, 'must be at least today')
    end
  end
  
end
