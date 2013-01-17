class UserResourceViewController < ApplicationController
  
  def index
    
  end
   
  def update
    
  end
  
  def create
    u_id = current_user == nil ? 0 : current_user.id
    r_id = params[:resource_id]
    UserResourceView.create(:resource_id => r_id, :user_id => u_id)
    respond_to do |format|  
        format.html { render :status=>200 }  
        format.json { render :status=>200, :json=>{:success=>true}}  
    end
  end
  
  def destroy
    
  end
  
end
