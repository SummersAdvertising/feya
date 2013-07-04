# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Cart::Application.initialize!

if Rails.env == 'development'
  Rails.logger.info "Delayed::Job is executed synchronously in #{Rails.env} mode."
  Delayed::Job.class_eval do
    def self.enqueue(obj)
      Rails.logger.info "Delayed::Job:SYNC START"
      obj[:payload_object].perform
      Rails.logger.info "Delayed::Job:SYNC END"
    end
  end 
end