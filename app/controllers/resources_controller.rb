require 'will_paginate/array'

class ResourcesController < ApplicationController
  def index

  end
  
  def create
    params[:resource][:user_id] = current_user.id
    @resource = Resource.new(params[:resource])
    @resource[:youtubeID] = self.isYoutube(@resource[:link])
    @resource.save
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

   def search
   # raise params.to_s
    @resource = Resource.search(params)

    unless params[:filter].nil? 
      case params[:filter][0][:sort].downcase
      when "newest"
        @resource = @resource.to_a.sort_by!{|resource| resource.created_at }.paginate(:page=>1,:per_page=>15)
      when "votes"
        @resource = @resource.to_a.sort_by!{|a| a.reputation_for(:votes).to_i }.reverse.paginate(:page=>1,:per_page=>15)
      else
        @resource = @resource.to_a.paginate(:page => 1, :per_page => 15)
      end
    end

    @resource
   end
end
