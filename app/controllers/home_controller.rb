class HomeController < ApplicationController
  def index
      if params[:tag] && params[:tag] != ""
        @resources = Resource.tagged_with(params[:tag]).find_with_reputation(:votes, :all, order: "votes desc")
      else
        @resources = Resource.find_with_reputation(:votes, :all, :limit => 10, order: "votes desc")
      end
      @resource = Resource.new
  end
end
