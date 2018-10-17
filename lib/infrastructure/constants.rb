module Infrastructure
  module Constants
    FILTER_TWEETS_DEFAULT = {
      filter: 'links',
      :'-filter' => 'retweets'
    }.freeze

    FILTER_PARAMS_CONNECTORS = {
      from: 'OR'
    }.freeze

    URL_HYPERLINK_TYPE = 'hyperlink'.freeze
    URLS_TABLE_HEADERS = %w(url type publisher created_at lang entities).freeze
  end
end
