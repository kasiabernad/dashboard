class RefreshLoadCreatorDriverJob
  include Sidekiq::Worker
  
  def perform
    LoadCreatorDriver.refresh
  end
end
