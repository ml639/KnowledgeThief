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
      if Resource.unique_link?(params[:resource][:link])
        @resource = Resource.new(params[:resource])
        @resource[:youtubeID] = Resource.isYoutube(@resource[:link])
        @resource.save
        Resource.upload_image(@resource)
      else
        flash[:alert] = "This resource has already been added!"
      end
    # No link provided, so this must be a question
    else
      @resource = Resource.new(params[:resource])
      @resource.save
      @resource.update_attribute(:link, "/resources/"+@resource.id.to_s)
    end
    current_user.facebook.put_wall_post("I post a resource on www.knowledgethief.com")
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
    current_user.facebook.put_wall_post("I vote on a resource on www.knowledgethief.com")
  end

  def search
    # Make sure google(q, filter) is run first so the sort encompasses those results as well.
        # Make sure google(q, filter) is run first so the sort encompasses those results as well.
    filter = "site"
    if params[:filter] && !params[:filter].blank?
      filter = params[:filter].downcase
    end

    # Change this second parameter to filter when we figure out the organzation.
    ############ google(params[:q], filter) ####################################
    Resource.google(params[:q], "videos")

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

    current_user.facebook.put_wall_post("I just made a search on www.knowledgethief.com")

end
