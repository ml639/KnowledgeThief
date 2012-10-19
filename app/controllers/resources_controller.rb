class ResourcesController < ApplicationController
  def index
    if params[:tag] && params[:tag] != ""
      @resources = Resource.tagged_with(params[:tag])
    else
      @resources = Resource.all
    end
    @resource = Resource.new
  end
  def create
    @resource = Resource.new(params[:resource])
    @resource.save
    redirect_to resources_path
  end
end
