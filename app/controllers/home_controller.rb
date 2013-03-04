class HomeController < ApplicationController
  def index
  
      # 
      #if params[:tag] && params[:tag] != ""
      #  @resources = Resource.tagged_with(params[:tag]).find_with_reputation(:votes, :all, order: "votes desc")
      #else
      #  @resources = Resource.find_with_reputation(:votes, :all, :limit => 10, order: "votes desc")
      #end
      
      @resources =  Resource.all
      # unneeded, just use Path.all @user_paths = Path.user_paths(current_user) unless current_user.nil?
      if current_user && params[:selection_type] && params[:selection_type] == "recent"
        # @resources = Recent resources (pending User Activity gem)
        @resources = current_user.recently_viewed_resources
        @select_type = "Recent"
      else
        # @resources = Popular resources
        @resources = Resource.find_with_reputation(:votes, :all, :limit => 10, order: "votes desc")
        @select_type = "Popular"
      end
      
      # @resources = Recommended resources (pending User Activity gem)
  end
end
