class UsersController < ApplicationController
	def index
		if current_user

		else
			redirect_to (home_path), :notice => "Please, log in." 

		end
	end
end