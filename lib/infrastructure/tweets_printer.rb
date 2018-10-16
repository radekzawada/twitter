module Infrastructure
  class TweetsPrinter
    def print(tweets)
      response = prepare_response(tweets)
      puts response
    end

    private

    def prepare_response(tweets)
      tweets.to_s
    end
  end
end
