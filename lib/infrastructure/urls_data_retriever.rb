module Infrastructure
  class UrlsDataRetriever
    def retrieve(tweets)
      tweets.map { |tweet| fetch_data(tweet) }
    end

    private

    def fetch_data(tweet)
      {
        urls: fetch_urls(tweet),
        user: tweet.user.screen_name,
        created_at: tweet.created_at.strftime('%Y-%m-%d %H:%M:%S'),
        lang: tweet.lang,
        entities: fetch_entities(tweet),
        tweet_url: tweet.url
      }
    end

    def fetch_urls(tweet)
      urls = []
      urls.concat tweet.urls.map { |url| { url: url.url.to_s, type: Constants::URL_HYPERLINK_TYPE } }
      urls.concat tweet.media.map { |media| { url: media.url.to_s, type: media.type } }
      urls
    end

    def fetch_entities(tweet)
      result = []
      result.concat tweet.hashtags.map(&:text).map { |h| "##{h}" }
      result.concat tweet.user_mentions.map(&:screen_name).map { |u| "@#{u}" }
      result.concat tweet.symbols.map(&:text).map { |s| "$#{s}" }

      result
    end
  end
end
