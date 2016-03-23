class Visit < ActiveRecord::Base
  validates :user_id, :short_url_id, presence: true

  belongs_to :visitor,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :visited_url,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: :ShortenedUrl

  def self.record_visit!(user,shortened_url)
    Visit.create!(user_id: user.id, short_url_id: shortened_url.id)
  end
end
