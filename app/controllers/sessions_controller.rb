class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    before_action :require_log_out, only: [:new, :create]

    skip_before_action :require_login, only: [:new, :create]

    def new

    end

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to @user
        else
            flash[:danger] = "Invalid Username or Password"
            redirect_to login_path
        end
    end

    def destroy
        session.clear
        redirect_to login_path
    end

    def about
    end

    private

    def require_log_out
        if logged_in?
            redirect_to current_user
        end
    end
    
end
