class ResourcesController < ApplicationController
  def index
    if params[:tag] && params[:tag] != ""
      @resources = Resource.tagged_with(params[:tag]).find_with_reputation(:votes, :all, order: "votes desc")
    else
      @resources = Resource.find_with_reputation(:votes, :all, :limit => 10, order: "votes desc")
    end
    @resource = Resource.new
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
  
  
end
