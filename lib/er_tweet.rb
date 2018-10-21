Dir['./lib/**/*.rb'].each { |file| require file }
require 'thor'

module ERTweet
  class CLI < Thor
    desc 'filter_with_urls [from] [to]', 'filter tweets with urls from twitter'
    option :since, default: nil, aliases: '-f', required: false
    option :until, default: nil, aliases: '-u', required: false
    def filter_with_urls(since_date = nil, until_date = nil)
      params = { since: since_date, until: until_date }
      tweets = dependencies_assembler.filter_tweets_with_urls_action.perform(params)
      table = urls_table_builder.build(tweets)
      tweets_printer.print(table)
    end

    private

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
