module Infrastructure
  class DependenciesAssembler
    def filter_tweets_with_urls_action
      Infrastructure::Actions::FilterTweetsWithUrlsAction.new(
        tweets_repository: tweets_repository
      )
    end

    def tweets_printer
      Infrastructure::TweetsPrinter.new
    end

    def urls_table_builder
      Infrastructure::UrlsTableBuilder.new(
        urls_data_retriever: urls_data_retriever
      )
    end

    private

    def tweets_repository
      Infrastructure::Repositories::TweetsRepository.new(
        user_name: user_name,
        query_builder: tweets_query_builder,
        twitter_client: twitter_client
      )
    end

    def urls_data_retriever
      Infrastructure::UrlsDataRetriever.new
    end

    def tweets_query_builder
      Infrastructure::Queries::Builders::TweetsWithUrls.new(
        params_sanitizer: params_sanitizer,
        connectors: Constants::FILTER_PARAMS_CONNECTORS
      )
    end

    def params_sanitizer
      Infrastructure::Queries::Params::TweetsWithUrlsSanitizer.new(
        Infrastructure::Constants::FILTER_TWEETS_DEFAULT,
        user_name
      )
    end

    def twitter_client
      Twitter::REST::Client.new(
        consumer_key: ENV['TWITTER_API_CONSUMER_KEY'],
        consumer_secret: ENV['TWITTER_API_CONSUMER_SECRET']
      )
    end

    def user_name
      ENV['TWITTER_USER_NAME']
    end
  end
end
