class UsersController < ApplicationController
	def index
		if current_user
			#raise current_user.to_yaml
			#return current_user
		else
			redirect_to (home_path), :notice => "Please, log in." 

		end
	end
end