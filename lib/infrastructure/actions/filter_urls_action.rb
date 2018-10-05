module Infrastructure
  module Actions
    class FilterUrlsAction
      def initialize(dependencies)
        @urls_printer = dependencies.fetch(:urls_printer)
      end

      def perform
        urls = find
        urls_printer.print(urls)
      end

      private

      def find
        []
      end

      attr_reader :urls_printer
    end
  end
end
