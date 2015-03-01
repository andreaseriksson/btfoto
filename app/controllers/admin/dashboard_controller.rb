module Admin
  class DashboardController < ApplicationController

    before_action :authenticate_user

    def index
      @dashboard = Dashboard.new
    end
  end
end
