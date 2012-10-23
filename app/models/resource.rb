class Resource < ActiveRecord::Base
  belongs_to :user

  has_reputation :votes, source: :user, aggregated_by: :sum

  attr_accessible :title, :description, :link, :tag_list, :user_id, :youtubeID
  acts_as_taggable
  # acts_as_votable
end
