class Resource < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  belongs_to :user
  has_many :resource_views, :class_name => 'UserResourceView'

  after_touch() { tire.update_index }
  has_reputation :votes, source: :user, aggregated_by: :sum

  attr_accessible :title, :description, 
                  :link, :tag_list, :user_id, 
                  :youtubeID, :type, :media_type
  acts_as_taggable

  mapping do 
      indexes :id,  :index => :not_analyzed
      indexes :title, :analyzer => 'standard', :boost => 40
      indexes :tag_list, :analyzer => 'standard', :boost => 8
      indexes :description, :analyzer => 'standard', :boost => 2
      indexes :user_id, :analyzer => 'standard'
      indexes :media_type, :index => :not_analyzed 
  end

  def self.search(params)
    tire.search(load: true,
                :page => (params[:page] || 1), 
                :per_page => 15, :fuzziness => 0.1,
                :default_operator => "OR" ) do
        query { string params[:q]} if params[:q].present?
        unless params[:filter].nil?
         unless params[:filter][0][:media_type].blank?
          filter :term, :media_type => params[:filter][0][:media_type].downcase
         end
        end
    end
  end

end
