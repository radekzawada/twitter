module Infrastructure
  module Actions
    class FilterTweetsWithUrlsAction
      def initialize(dependencies)
        @tweets_repository = dependencies.fetch(:tweets_repository)
      end

      def perform(params)
        find(params)
      end

      private

      attr_reader :tweets_printer, :tweets_repository

      def find(params)
        tweets_repository.find_with_urls(params)
      end
    end
  end
end
