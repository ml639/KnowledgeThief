class UserResourceViewController < ApplicationController
  
  def index
    
  end
   
  def update
    
  end
  
  def create
    user_id = current_user.id
    resource_id = params[:resource_id]
    respond_to do |format|  
        format.html { render :status=>200 }  
        format.json { render :status=>200, :json=>{:success=>true}}  
    end
  end
  
  def destroy
    
  end
  
end
