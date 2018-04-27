class SessionsController < ApplicationController
	skip_before_action :require_login, except:[:destroy]
	# requires login except at logout
	def new
	end

	def create
		@user = User.find_by(email: params[:email])
		errors = []

		if @user
			if @user.authenticate(params[:password])
				session[:user_id] = @user.user_id

				return redirect_to songs_path
			else
				errors << 'Invalid password'
			end
		else
			errors << 'Email does not exist in records. Please register first.'
		end

		redirect_to :back, alert: errors

	end

	def destroy
		session.delete :user_id if session.key? 'user_id'

		redirect_to "/login"
	end
end
