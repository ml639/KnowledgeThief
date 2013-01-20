class Resource < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :user
  has_many :resource_views, :class_name => 'UserResourceView'

  has_reputation :votes, source: :user, aggregated_by: :sum

  attr_accessible :title, :description, 
                  :link, :tag_list, :user_id, 
                  :youtubeID, :type
  acts_as_taggable

  mapping do 
      indexes :id,  :index => :not_analyzed
      indexes :title, :analyzer => 'snowball', :boost => 40
      #tag_list not being indexed correctly...
      indexes :tag_list, :analyzer => 'snowball', :boost => 8
      indexes :description, :analyzer => 'snowball', :boost => 2
      #user_id index is having troubles
      indexes :user_id, :analyzer => 'snowball'
  end

  def self.search(params)
    tire.search(load: true,
                :page => (params[:page] || 1), 
                :per_page => 15 ) do
        query { string params[:q]} if params[:q].present?
#        filter :term, media_type: params[:filter]
# add in later                sort  { by    :votes, 'desc' }
    end
  end

end
