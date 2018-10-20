require 'sidekiq/scheduler'
Sidekiq::Scheduler.dynamic = true
Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(Rails.root.join("config", "sidekiq.yml"))
  end
end
