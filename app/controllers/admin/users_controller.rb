module Admin
  class UsersController < ApplicationController
    respond_to :html
  
    def new
      @user = User.new
    end
  
    def create
      @user = sign_up(user_params)
      sign_in(@user)
      respond_with @user, location: admin_root_path
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
