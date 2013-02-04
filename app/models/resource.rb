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



  def self.deliver(id)
    r = find(id)
    url = PostRank::URI.clean(r.link)

    side_size = 300
    crop_side_size = 300

    kit = IMGKit.new(url, :quality => 50,
                          :width   => side_size,
                          :height  => side_size,
                          "crop-w" => crop_side_size,
                          "crop-h" => crop_side_size,
                          "zoom"   => 0.35,
                          "disable-smart-width" => true,
                          "load-error-handling" => "ignore")

    img   = kit.to_img(:jpg)

    file  = Tempfile.new(["resource_#{r.id}", 'jpg'], 'tmp',
                         :encoding => 'ascii-8bit')
    file.write(img)
    file.flush
    r.snapshot = file
    r.save
    file.unlink
  end
end


