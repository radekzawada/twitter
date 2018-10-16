Dir['./lib/**/*.rb'].each { |file| require file }
require 'thor'

module Twits
  class CLI < Thor
    desc 'filter_with_urls', 'filter tweets with urls from twitter'
    def filter_with_urls
      tweets = dependencies_assembler.filter_tweets_with_urls_action.perform(filter_params)
      tweets_printer.print(tweets)
    end

    private

    def filter_params
      {}
    end

    def dependencies_assembler
      @dependencies_assembler ||= Infrastructure::DependenciesAssembler.new(self)
    end

    def tweets_printer
      @tweets_printer ||= dependencies_assembler.tweets_printer
    end
  end
end

Twits::CLI.start(ARGV)
