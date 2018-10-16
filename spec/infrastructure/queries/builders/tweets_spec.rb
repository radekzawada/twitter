RSpec.describe Infrastructure::Queries::Builders::Tweets do
  describe '.build_filter_with_urls_query' do
    subject(:builder) { described_class.new(params_sanitizer: params_sanitizer, connectors: connectors) }
    let(:params_sanitizer) { double(Infrastructure::Queries::Params::FilterTweetsWithUrlsSanitizer) }
    let(:sanitized_params) { { filter: ['links'], :'-filter' => ['retweets'], from: [user_screen_name] } }
    let(:users_names) { [] }
    let(:user_screen_name) { 'user' }
    let(:expected_result) { 'filter:links -filter:retweets from:user' }
    let(:connectors) { { from: 'OR' } }

    it 'build query with default values' do
      expect(params_sanitizer).to receive(:sanitize!).with(sanitized_params)
      expect(builder.build_filter_with_urls_query(sanitized_params, users_names)).to eq(expected_result)
    end

    context 'when user contains some friends' do
      let(:users_names) { %w(user1 user2 user3) }
      let(:expected_result) { 'filter:links -filter:retweets from:user OR from:user1 OR from:user2 OR from:user3' }

      it 'build query with all users' do
        expect(params_sanitizer).to receive(:sanitize!).with(sanitized_params)
        expect(builder.build_filter_with_urls_query(sanitized_params, users_names)).to eq(expected_result)
      end
    end
  end
end
