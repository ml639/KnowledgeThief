class InPathsController < ApplicationController

  def index
  	 @in_paths = InPath.all(:order=>:path_id)
  end

  def view
  	 @in_paths = InPath.this_path(params[:path_id])
  end

  def add_resource_to_path 
    @path = Path.find(params[:path_id])
    @resource = Resource.find(params[:resource_id])
    @count_resources = InPath.where('path_id = ?', params[:path_id]).size

    InPath.new(:path => @path, :resource => @resource,
               :resource_path_position => @count_resources+1).save 
    redirect_to :back
  end

  def remove_resource_from_path
    path_id = params[:path_id]
    resource_id = params[:resource_id]
    position = params[:position]

    InPath.delete_all(['path_id = ? and resource_id = ? and resource_path_position = ?',
                 path_id, resource_id, 
                 position])
    redirect_to :back
  end

  def change_resource_order_in_path

  end

end