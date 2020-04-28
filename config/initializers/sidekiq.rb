class SidekiqLogstashFormatter < Sidekiq::Logger::Formatters::Base
  def call(severity, time, program_name, message)
    hash = {
      ts: time.utc.iso8601(3),
      pid: ::Process.pid,
      tid: tid,
      lvl: severity,
      msg: message
    }
    c = ctx
    # ctx needs to be merged so its keys are in
    # root level of document
    hash.merge!(c) unless c.empty?

    Sidekiq.dump_json(hash) << "\n"
  end
end
Sidekiq.configure_server do |config|
  # Please note: formatter specified as part of LogStashLogger
  config.logger = LogStashLogger.new(type: :tcp, host: ENV.fetch('LOGSTASH_HOST', 'localhost'), 
    port: 5000, formatter: SidekiqLogstashFormatter)
end

Sidekiq.configure_client do |config|
    # config.log_formatter = Lograge::Formatters::Logstash.new
    # config.logger = LogStashLogger.new(type: :tcp, host: ENV.fetch('LOGSTASH_HOST', 'localhost'), port: 5000)
    config.logger = LogStashLogger.new(type: :tcp, host: ENV.fetch('LOGSTASH_HOST', 'localhost'), port: 5000, formatter: SidekiqLogstashFormatter)
  end