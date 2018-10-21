RSpec.describe Infrastructure::Repositories::TweetsRepository do
  describe '.find_with_urls' do
    subject(:repo) do
      described_class.new(
        twitter_client: twitter_client,
        user_name: user_name,
        query_builder: query_builder
      )
    end

    let(:twitter_client) { double(Twitter::REST::Client) }
    let(:user_name) { 'user' }
    let(:query_builder) { double(Infrastructure::Queries::Builders::TweetsWithUrls) }
    let(:params) { {} }
    let(:friends_names) { %w[friend1 friend2 friend3 friend4] }
    let(:friends) { friends_names.map { |friend_name| double(screen_name: friend_name) } }
    let(:query) { { param1: 'val1', param2: 'val2' } }
    let(:tweets) { 2.times.map.with_index { |_v, i| double('Tweet', url: "http://:tweet_#{i}.com") } }

    it 'returns tweets list' do
      expect(twitter_client).to receive(:friends).with(user_name) { friends }
      expect(query_builder).to receive(:build_filter_with_urls_query).with(params, friends_names) { query }
      expect(twitter_client).to receive(:search).with(query) { tweets }
      expect(repo.find_with_urls(params)).to be_a(Array)
    end
  end
end
