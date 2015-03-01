class Appointment < ActiveRecord::Base
  validates :label, presence: true
  validates :start_time, presence: true
  validate :start_time_is_valid_datetime, on: :create
  validate :start_time_is_at_least_today, on: :create

  validates_presence_of :name, on: :update
  validates_presence_of :email, on: :update
  validates_presence_of :phone, on: :update

  def week
    start_time.strftime('%V')
  end

  def book!
    update_attribute :booked, true
  end

  private

  def start_time_is_valid_datetime
    errors.add(:start_time, 'must be a valid date') unless start_time.is_a?(Time)
  end

  def start_time_is_at_least_today
    errors.add(:start_time, 'must be at least today') if start_time.is_a?(Time) && Date.today > start_time
  end
end
