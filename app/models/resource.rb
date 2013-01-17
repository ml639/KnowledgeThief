class Resource < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :user
  has_many :resource_views, :class_name => 'UserResourceView'

  has_reputation :votes, source: :user, aggregated_by: :sum

  attr_accessible :title, :description, :link, :tag_list, :user_id, :youtubeID
  acts_as_taggable

  mapping do 
      indexes :id,  :index => :not_analyzed
      indexes :title, :analyzer => 'snowball', :boost => 40
      indexes :tag_list, :analyzer => 'snowball', :boost => 8
      indexes :description, :analyzer => 'snowball', :boost => 2
      indexes :user_id, :analyzer => 'snowball'
  end
end
