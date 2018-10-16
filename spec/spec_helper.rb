require 'bundler/setup'
require 'twits'
require 'twitter'
require 'yaml'
require 'ostruct'
require './config/application.rb'

Dir['./lib/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
