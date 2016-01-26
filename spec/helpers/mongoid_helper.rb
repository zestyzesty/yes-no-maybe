require 'mongoid'
Mongoid.load!("spec/support/mongoid.yml", :test)
Mongo::Logger.logger.level = ::Logger::FATAL

