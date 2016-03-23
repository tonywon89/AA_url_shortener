class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, :submitter_id, presence: true
  validates :long_url, :short_url, uniqueness: true

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: :User

  has_many :visits,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    random = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64
    end
    random
  end

  def self.create_for_user_and_long_url!(user, long_url_input)
    ShortenedUrl.create!(
      long_url: long_url_input,
      short_url: random_code,
      submitter_id: user.id
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    recently = (10.minutes.ago..Time.now)
    visitors.where( created_at: recently).count

  end
end
