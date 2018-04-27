class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
    # requires login for new and create actions only+
    def new
        # render login page
    end

    def show
        p "Session id is #{session[:user_id]}"
        @record = Join.where(user_id: params[:id])
        p "Length of the record is #{@record.length}"
        render "/users/show"
        # handled by memoization below
    end

    def destroy
        # Log User out
        # set session[:user_id] to null
        # redirect to login page
    end

    def main
        @main = session[:main]
        p @main, "references"
        render "/users/main"
    end

    def create
        if new_user.valid?
            session[:user_id] = new_user.id
            # this will store our new user in session

            return redirect_to songs_path
        end

        redirect_to :back, alert: new_user.errors.full_messages
    end

private
    # memoization
    helper_method def user
        @user ||=User.find(params[:id])
    end
    
    helper_method def new_user
        @new_user ||=User.create(user_params)
    end
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end 
end
