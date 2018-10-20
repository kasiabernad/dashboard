class DashboardController < ApplicationController
  def index
    @loads = LightLoad.all
  end
end
