require 'will_paginate/array'
require 'google/api_client'

class ResourcesController < ApplicationController
  def index
      @resources = Resource.all
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def create

    # Usability concern here... need to make sure that they are redirected back here once they log in or something
    if current_user == nil
      flash[:alert] = "You must log in to submit a resource!"
      redirect_to resources_path
      return
    else
      params[:resource][:user_id] = current_user.id
    end

    # If no link is provided, it is a question
    if(params[:resource][:link] != nil)
      # Not a question, check to see if this resource unique
      params[:resource][:link] = PostRank::URI.clean(params[:resource][:link])
      if unique_link?(params[:resource][:link])
        @resource = Resource.new(params[:resource])
        @resource[:youtubeID] = self.isYoutube(@resource[:link])
        upload_image(@resource)
        @resource.save
      else
        flash[:alert] = "This resource has already been added!"
      end
    # No link provided, so this must be a question
    else
      @resource = Resource.new(params[:resource])
      @resource.save
      @resource.update_attribute(:link, "/resources/"+@resource.id.to_s)
    end


    redirect_to resources_path
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @resource = Resource.find(params[:id])
    @resource.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
        format.html { redirect_to :back, notice: "Thank you for voting" }
        format.json { render :status=>200, :json=>{:success=>true}}
    end
  end

  def isYoutube(youtube_url)
    regex = %r{http://www.youtube.com}
    if youtube_url[regex]
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
      thumbnail_Link = "http://img.youtube.com/vi/#{youtube_id}/1.jpg"
    else
      thumbnail_Link = nil
    end
    thumbnail_Link
  end

  def unique_link?(url)
    Resource.find_by_link(url) == nil
  end

  def search
    # Make sure google(q, filter) is run first so the sort encompasses those results as well.
        # Make sure google(q, filter) is run first so the sort encompasses those results as well.
    filter = "site"
    if params[:filter] && !params[:filter].blank?
      filter = params[:filter].downcase
    end

    # Change this second parameter to filter when we figure out the organzation.
    # google(params[:q], filter)
    google(params[:q], "videos")



      unless params[:q].blank?
        @resource = Resource.full_search(params[:q])
      else
        @resource = Resource.all
      end

     @resource = @resource.reject!{|r| !r.media_type.eql? params[:filter].downcase } unless params[:filter].blank?

     unless params[:sort].blank?
      case params[:sort].downcase
      when 'newest'
         then @resource = @resource.sort_by{|r| r.created_at}
      when 'votes'
         then @resource = @resource.sort_by!{|r| r.reputation_for(:votes).to_i}.reverse
      end
     end
     @resource = @resource.paginate(:page => (params[:page] || 1), :per_page => 15) unless @resource.nil?
  end


  def google(q, filter)
    # Authenticating into Google's API
    client = Google::APIClient.new(:key => 'AIzaSyBmByzcpxbsLsg7u7GlF8I5dJwITuSyCNU', :authorization => nil)

    # Discover the Custom Search API
    search = client.discovered_api('customsearch')

    # Search Google CSE
    #   cx => the custom search engine that will search the entire web
    response = client.execute(
      :api_method => search.cse.list,
      :parameters => {
        'q' => "#{q} #{filter}",
        'key' => 'AIzaSyBmByzcpxbsLsg7u7GlF8I5dJwITuSyCNU',
        'cx' => '016679902470578435641:scswmfxveaa'
      }
    )

    # Decode the results
    results = ActiveSupport::JSON.decode(response.body, {:symbolize_names => true})

    # Return an empty array if Google CSE limit has been met.
    #results["items"] == nil ? [] : results["items"]
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

  # def upload_images
  #   all_r = Resource.all
  #   all_r.each do |r|
  #     upload_image(r)
  #   end
  # end

  # To display the image in view: <%= image_tag @resource.snapshot.url %>
  def upload_image(r)
    Resource.delay.deliver(r.id)
    # url = PostRank::URI.clean(r.link)

    # side_size = 300
    # crop_side_size = 300

    # kit = IMGKit.new(url, :quality => 50,
    #                       :width   => side_size,
    #                       :height  => side_size,
    #                       "crop-w" => crop_side_size,
    #                       "crop-h" => crop_side_size,
    #                       "zoom"   => 0.35,
    #                       "disable-smart-width" => true,
    #                       "load-error-handling" => "ignore")

    # img   = kit.to_img(:jpg)

    # file  = Tempfile.new(["resource_#{r.id}", 'jpg'], 'tmp',
    #                      :encoding => 'ascii-8bit')
    # file.write(img)
    # file.flush
    # r.snapshot = file
    # r.save
    # file.unlink
  end

end
