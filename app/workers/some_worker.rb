class SomeWorker
  include Sidekiq::Worker

  def perform
    puts "in progress"
  end
end