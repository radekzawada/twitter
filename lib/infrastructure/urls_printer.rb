module Infrastructure
  class UrlsPrinter
    def print(urls)
      response = prepare_response(urls)
      puts response
    end

    private

    def prepare_response(urls)
      urls.to_s
    end
  end
end
