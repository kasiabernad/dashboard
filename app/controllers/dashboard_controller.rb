class DashboardController < ApplicationController
  def index
    extracted_month = "date_trunc('month', startdate)"
    # month = "to_char(#{extracted_month}, 'MM/YYYY')"
    @light_loads = LightLoad.group(extracted_month).order(extracted_month).count
    @match_percentage = { matched_loads: MatchedLoad.count, not_matched_loads: Load.count - MatchedLoad.count }

    @drivers_with_big_cars = User.joins(:user_vehicles)
                                 .merge(
                                   UserVehicle.joins(:vehicle).merge(
                                     Vehicle.where('vehicles.capacity > 10000')
                                   )
                                 )
  end
end
