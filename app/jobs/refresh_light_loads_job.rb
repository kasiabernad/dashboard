class RefreshLightLoadsJob
  include Sidekiq::Worker
  
  def perform
    LightLoad.refresh
  end
end
