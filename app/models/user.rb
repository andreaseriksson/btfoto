class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, format: { 
    with: /\A([\A@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 
  }
  validate :allowed_to_register, on: :create
  
  private
  
  def allowed_to_register
    allowed_emails = CONFIG[:allowed_emails].split(" ")
    errors.add(:email, 'Not allowed') unless allowed_emails.include?(email)
  end
  
end
