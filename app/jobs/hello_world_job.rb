class HelloWorldJob < ActiveJob::Base

  def perform
    puts 'aaa'
  end
end
