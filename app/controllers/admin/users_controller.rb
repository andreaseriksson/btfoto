module Admin
  class UsersController < ApplicationController

    before_action :authenticate_user, only: [:index, :edit, :update, :destroy]
    layout :resolve_layout

    def index
      @users = User.all
    end

    def new
      @user = User.new
      redirect_to admin_root_path if current_user
    end

    def create
      @user = sign_up(user_params)
      sign_in(@user)
      respond_with @user, location: admin_root_path
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to admin_users_path, notice: 'User was successfully deleted.'
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def resolve_layout
      case action_name
      when 'new', 'create'
        'login'
      else
        'backend'
      end
    end

  end
end
