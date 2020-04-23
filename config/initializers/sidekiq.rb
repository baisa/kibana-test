Sidekiq.configure_server do |config|
  config.log_formatter = Sidekiq::Logger::Formatters::JSON.new # Lograge::Formatters::Logstash.new
  #config.logger = LogStashLogger.new(type: :tcp, host: ENV.fetch('LOGSTASH_HOST', 'localhost'), port: 5000)
end
Sidekiq.configure_client do |config|
    config.log_formatter = Lograge::Formatters::Logstash.new
    config.logger = LogStashLogger.new(type: :tcp, host: ENV.fetch('LOGSTASH_HOST', 'localhost'), port: 5000)
  end