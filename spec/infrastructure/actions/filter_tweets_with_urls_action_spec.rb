RSpec.describe Infrastructure::Actions::FilterTweetsWithUrlsAction do
  describe '.perform' do
    subject(:action) do
      described_class.new(
        tweets_printer: tweets_printer,
        tweets_repository: tweets_repository
      )
    end

    let(:tweets_printer) { double(Infrastructure::TweetsPrinter) }
    let(:tweets_repository) { double(Infrastructure::Repositories::TweetsRepository) }
    let(:params) { {} }
    let(:tweets) { 5.times.map.with_index { |_v, i| double('Tweet', url: "http://:tweet_#{i}.com") } }

    it 'returns tweets from repository' do
      expect(tweets_repository).to receive(:find_with_urls).with(params) { tweets }
      expect(action.perform(params)).to eq(tweets)
    end
  end
end
