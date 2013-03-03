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
  has_many :in_paths
  has_many :paths, :through => :in_paths

  has_many :views, :class_name => 'UserResourceView'
  has_many :comments
  has_reputation :votes, source: :user, aggregated_by: :sum

  attr_accessible :title, :description, :link, :tag_list,
                  :user_id, :youtubeID, :media_type, :snapshot, :snapshot_file_name

  acts_as_taggable

  has_attached_file :snapshot,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :default_url => "resourceex.JPG"



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

   ###CLEANUP_L: Need to make sure this is called in seeds.rb and also in google(q, filter)
  def self.isYoutube(youtube_url)
    regex = %r{http://www.youtube.com}
    if youtube_url[regex]
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]

      ###CLEANUP_L: The following line of code is never used right?
      youtube_id = $5
      thumbnail_Link = "http://img.youtube.com/vi/#{youtube_id}/1.jpg"
    else
      thumbnail_Link = nil
    end
    thumbnail_Link
  end

  def self.unique_link?(url)
    Resource.find_by_link(url) == nil
  end


  def self.google(q, filter)
    # Authenticating into Google's API
    client = Google::APIClient.new(:key => "AIzaSyBmByzcpxbsLsg7u7GlF8I5dJwITuSyCNU", :authorization => nil)

    # Discover the Custom Search API
    search = client.discovered_api('customsearch')

    # Search Google CSE
    #   cx => the custom search engine that will search the entire web (doesn't need to be hidden)
    response = client.execute(
      :api_method => search.cse.list,
      :parameters => {
        'q' => "#{q} #{filter}",
        'key' => "AIzaSyBmByzcpxbsLsg7u7GlF8I5dJwITuSyCNU",
        'cx' => '016679902470578435641:scswmfxveaa'
      }
    )

    # Decode the results
    results = ActiveSupport::JSON.decode(response.body, {:symbolize_names => true})

    # Return an empty array if Google CSE limit has been met.
    results["items"] = results["items"] == nil ? [] : results["items"]
    #results = {"items" => []}

    # Now add those to our database here (call this method before )
    # attr_accessible :title, :description, :link, :tag_list,
    #              :user_id, :youtubeID, :media_type
    # google_result["title"], google_result["link"], google_result["snippet"]


    # Example
    # Harvard CS61 - Computer Systems|
    # video|http://cm.dce.harvard.edu/2012/01/13836/publicationListing.shtml|
    # Harvard's version of CS4400. Topics include assembly, buffer overflow,
    # optimization and virtual memory.|computer systems, machine organization

    results["items"].each do |r|
      r["link"] = PostRank::URI.clean(r["link"])
      if unique_link?(r["link"])
        temp_resource = Resource.create!(:title => r["title"],
                                         :link => r["link"],
                                         :description => r["snippet"],
                                         :media_type => "other",
                                         :user_id => 1)
        temp_resource.tag_list = q
        upload_image(temp_resource)
        temp_resource.save!

      end
    end


  end

  # To display the image in view: <%= image_tag @resource.snapshot.url %>
  def self.upload_image(r)
    Resource.delay.deliver(r.id)
  end

  # Humanized version of time
  def time
    ChronicDuration.output(time_sec, :format => :long)
  end

  # Returns time in seconds
  def time_sec
    self.views.sum {|v| v.updated_at.to_i - v.created_at.to_i}
  end

end


