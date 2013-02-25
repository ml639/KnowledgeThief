class UserResourceViewController < ApplicationController

  def index

  end

  def update
    # Save in order to update "updated_at" so we know the end time
    u_id = current_user == nil ? 0 : current_user.id
    r_id = params[:resource_id]
    # Grab the latest entry and save it to
    urv = UserResourceView.where(resource_id: r_id, user_id: u_id).order('created_at desc').first

    urv.updated_at = Time.now

    # Save it to update the "updated_at" column (which we will use to calculate Muse Time (MT))
    urv.save!

    respond_to do |format|
        format.html { render :status=>200 }
        format.json { render :status=>200, :json=>{:success=>true}}
    end
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
