class RefreshTaxNumbersJob
  include Sidekiq::Worker
  
  def perform
    TaxNumber.refresh
  end
end
