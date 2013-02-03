class Resource < ActiveRecord::Base
  include PgSearch
  pg_search_scope :full_search,
    :against => {
    :title => 'A',
    :description => 'B',
    :user_id => 'C'
   },
    :using => {
    :tsearch => {:any_word => true,
                 :prefix=> true,
                 :dictionary => "english"},
    :trigram => {}
   },
    :associated_against => {
    :tags => [:name]
   }

  belongs_to :user
  has_many :resource_views, :class_name => 'UserResourceView'
  has_many :comments
  has_reputation :votes, source: :user, aggregated_by: :sum

  attr_accessible :title, :description, :link, :tag_list,
                  :user_id, :youtubeID, :media_type, :snapshot, :snapshot_file_name

  acts_as_taggable

  has_attached_file :snapshot,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"


end
