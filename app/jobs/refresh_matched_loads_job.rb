class RefreshMatchedLoadsJob
  include Sidekiq::Worker
  
  def perform
    MatchedLoad.refresh
  end
end
