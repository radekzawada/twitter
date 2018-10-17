require 'pry'
RSpec.describe Infrastructure::UrlsTableBuilder do
  describe '.build' do
    subject(:builder) { described_class.new(urls_data_retriever: data_retriever) }
    let(:data_retriever) { double(Infrastructure::UrlsDataRetriever) }
    let(:tweets) { Array(2) { Fabricate.build(:tweet) } }
    let(:tweet) { build(:tweet) }
    let(:urls_1) { [{ url: 'http://tweeter.com/claud', type: 'hyperlink' }] }
    let(:urls_2) { [{ url: 'http://tweeter.com/chooper', type: 'gif' }] }
    let(:tweets_data) do
      [
        {
          entities: ['#omnis', '#ut', '@dolorum', '@facilis', '$consectetur'],
          created_at: Time.at(1_439_232_400).strftime('%Y-%m-%d %H:%M:%S'),
          lang: 'pl',
          tweet_url: 'http://tweeter.com/santos.strosin',
          urls: urls_1,
          user: 'Carmine'
        },
        {
          entities: ['#omnis', '#ut', '@dolorum'],
          created_at: Time.at(1_449_232_400).strftime('%Y-%m-%d %H:%M:%S'),
          lang: 'en',
          tweet_url: 'http://tweeter.com/santa',
          urls: urls_2,
          user: 'Santa'
        }
      ]
    end
    let(:expected_result) { File.read('./spec/fixtures/tweets_table.txt') }

    it 'prints table with urls' do
      expect(data_retriever).to receive(:retrieve).with(tweets) { tweets_data }
      expect(builder.build(tweets).to_s).to eq(expected_result)
    end

    context 'When tweet has more than one url' do
      let(:urls_1) do
        [
          { url: 'http://tweeter.com/claud', type: 'hyperlink' },
          { url: 'http://tweeter.com/cl', type: 'photo' }
        ]
      end
      let(:expected_result) { File.read('./spec/fixtures/tweets_table_v2.txt') }

      it 'prints tweets data for each tweet url' do
        expect(data_retriever).to receive(:retrieve) { tweets_data }
        expect(builder.build(tweets).to_s).to eq(expected_result)
      end
    end
  end
end
