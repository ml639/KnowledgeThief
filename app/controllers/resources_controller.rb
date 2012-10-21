class ResourcesController < ApplicationController
  def index
    if params[:tag] && params[:tag] != ""
      @resources = Resource.tagged_with(params[:tag]).find_with_reputation(:votes, :all, order: "votes desc")
    else
      @resources = Resource.find_with_reputation(:votes, :all, :limit => 10, order: "votes desc")
    end
    @resources = Resource.new
  end
  def create
    params[:resource][:user_id] = current_user.id
    @resources = Resource.new(params[:resource])
    @resources.save
    redirect_to resources_path
  end
  def vote
    value = params[:type] == "up" ? 1 : -1
    @resources = Resource.find(params[:id])
    @resources.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end
end
