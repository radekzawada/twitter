module Infrastructure
  class DependenciesAssembler
    def initialize(application)
      @application = application
    end

    def filter_tweets_with_urls_action
      Infrastructure::Actions::FilterTweetsWithUrlsAction.new(
        tweets_repository: tweets_repository
      )
    end

    def tweets_printer
      Infrastructure::TweetsPrinter.new
    end

    private

    attr_reader :application

    def tweets_repository
      Infrastructure::Repositories::TweetsRepository.new(
        user_name: user_name,
        query_builder: tweets_query_builder,
        twitter_client: twitter_client
      )
    end

    def tweets_query_builder
      Infrastructure::Queries::Builders::Tweets.new(
        params_sanitizer: params_sanitizer,
        connectors: Infrastructure::Queries::Connectors::FILTER_PARAMS_CONNECTORS
      )
    end

    def params_sanitizer
      Infrastructure::Queries::Params::FilterTweetsWithUrlsSanitizer.new(
        Infrastructure::Constants::FILTER_TWEETS_DEFAULT,
        user_name
      )
    end

    def twitter_client
      Twitter::REST::Client.new(
        consumer_key: configuration.twitter.consumer_key,
        consumer_secret: configuration.twitter.consumer_secret,
        access_token: configuration.twitter.access_token,
        access_token_secret: configuration.twitter.access_token_secret
      )
    end

    def configuration
      Application.config
    end

    def user_name
      ENV['TWITTER_USER_NAME']
    end
  end
end
