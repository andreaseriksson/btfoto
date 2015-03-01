module Admin
  class SessionsController < ApplicationController

    respond_to :html
    layout 'login'

    def new
      redirect_to admin_root_path if current_user
    end

    def create

      user = authenticate_session(session_params)

      sign_in(user) or set_flash_message
      respond_with user, location: admin_root_path
    end

    def destroy
      sign_out
      redirect_to admin_login_path
    end

    private

    def set_flash_message
      flash.now.notice = "Invalid username or password"
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
