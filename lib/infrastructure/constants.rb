module Infrastructure
  module Constants
    FILTER_TWEETS_DEFAULT = {
      filter: 'links',
      :'-filter' => 'retweets'
    }.freeze
  end
end
