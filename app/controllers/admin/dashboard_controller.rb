module Admin
  class DashboardController < ApplicationController
    
    before_action :authenticate
    
    def index
    end
  end
end
