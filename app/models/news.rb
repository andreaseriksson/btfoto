class News < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true

  scope :published, -> { where('published_at <= ?', Date.today).order(published_at: :desc) }
end
