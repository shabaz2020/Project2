class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    before_action :get_user, only:[:show, :edit, :update, :destroy]


    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Successfully updated!"
            redirect_to user_path(@user)
        else
            render :edit
        end
    end

    def destroy
        @user.destroy
        session.clear
        redirect_to '/'
    end

    private

    def get_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :username, :password, :password_confirmation)
    end

end
