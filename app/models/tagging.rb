class Tagging < ActiveRecord::Base
  belongs_to :shortened_url
  belongs_to :tag_topic
end
