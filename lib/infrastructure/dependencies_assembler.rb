module Infrastructure
  class DependenciesAssembler
    def initialize(application)
      @application = application
    end

    def filter_urls_action
      Infrastructure::Actions::FilterUrlsAction.new(
        urls_printer: urls_printer
      )
    end

    private

    def urls_printer
      Infrastructure::UrlsPrinter.new
    end

    attr_reader :application
  end
end
