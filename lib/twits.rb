Dir['./lib/**/*.rb'].each { |file| require file }
require 'thor'
require 'pry'

module Twits
  class CLI < Thor
    desc 'filter', 'filter urls from twitter'
    def filter
      dependencies_assembler.filter_urls_action.perform
    end

    private

    def dependencies_assembler
      @dependencies_assembler ||= Infrastructure::DependenciesAssembler.new(self)
    end
  end
end

Twits::CLI.start(ARGV)
