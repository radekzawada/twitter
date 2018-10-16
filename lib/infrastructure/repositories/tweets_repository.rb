require 'pry'
module Infrastructure
  module Repositories
    class TweetsRepository
      def initialize(dependencies)
        @twitter_client = dependencies.fetch(:twitter_client)
        @user_name = dependencies.fetch(:user_name)
        @query_builder = dependencies.fetch(:query_builder)
      end

      def find_with_urls(params)
        query = query_builder.build_filter_with_urls_query(params, all_user_friends_names)
        twitter_client.search(query).to_a
      end

      private

      attr_accessor :twitter_client, :user_name, :query_builder

      def all_user_friends_names
        twitter_client.friends(user_name).map(&:screen_name)
      end
    end
  end
end
