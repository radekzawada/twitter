require 'bundler/setup'
require 'er_tweet'
require 'twitter'
require 'yaml'
require 'ostruct'
require 'fabrication'
require 'faker'

Dir['./lib/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
