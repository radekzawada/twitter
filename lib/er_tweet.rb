Dir['./lib/**/*.rb'].each { |file| require file }
require 'thor'

module ERTweet
  class CLI < Thor
    desc 'filter_with_urls', 'filter tweets with urls from twitter'
    def filter_with_urls
      tweets = dependencies_assembler.filter_tweets_with_urls_action.perform(filter_params)
      table = urls_table_builder.build(tweets)
      tweets_printer.print(table)
    end

    private

    def filter_params
      {}
    end

    def dependencies_assembler
      @dependencies_assembler ||= Infrastructure::DependenciesAssembler.new
    end

    def tweets_printer
      @tweets_printer ||= dependencies_assembler.tweets_printer
    end

    def urls_table_builder
      @urls_table_builder ||= dependencies_assembler.urls_table_builder
    end
  end
end

ERTweet::CLI.start(ARGV)
