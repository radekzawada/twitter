require 'terminal-table'

module Infrastructure
  class UrlsTableBuilder
    def initialize(dependencies)
      @urls_data_retriever = dependencies.fetch(:urls_data_retriever)
    end

    def build(tweets)
      urls_data = urls_data_retriever.retrieve(tweets)
      ::Terminal::Table.new do |table|
        table.style = { border_bottom: false }
        table.headings = Constants::URLS_TABLE_HEADERS
        urls_data.map do |data|
          put_url_data_into_table(table, data)
        end
      end
    end

    private

    attr_accessor :urls_data_retriever

    def put_url_data_into_table(table, data)
      header = "tweet url: #{data[:tweet_url]}"
      table.add_row [{ value: header, colspan: Constants::URLS_TABLE_HEADERS.size, alignment: :center }]
      table.add_separator

      rows = data[:urls].map do |url|
        [url[:url], url[:type], *data.values_at(:user, :created_at, :lang), data[:entities].join(' ')]
      end

      rows.each { |row| table.add_row row }
      table.add_separator
    end
  end
end
