class RefreshRecursiveUsersJob
  include Sidekiq::Worker
  
  def perform
    RecursiveUser.refresh
  end
end
