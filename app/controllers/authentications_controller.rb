class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.json

  def index
    #@authentications = Authentication.all
    @authentications = current_user.authentications if current_user
  end

  def create
     omniauth = request.env["omniauth.auth"]
     #raise omniauth['credentials'].to_json
     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication
       flash[:notice] = "Signed in successfully."
       user = User.find_by_id(authentication.user_id)
       user.apply_omniauth(omniauth)
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Authentication successful."
       redirect_to authentications_url
     else
       user = User.new
       user.apply_omniauth(omniauth)
       if user.save
         flash[:notice] = "Signed in successfully."
         sign_in_and_redirect(:user, user)
       else
         session[:omniauth] = omniauth.except('extra')
         redirect_to new_user_registration_url
       end
     end
   end


  def failure
    flash[:notice] = "Could not log you in"
    redirect_to (home_path), :notice => "Could not log you in" 
  end
end
