class RefreshLightLoadsJob < ActiveJob::Base
  def perform
    LightLoad.refresh
  end
end
