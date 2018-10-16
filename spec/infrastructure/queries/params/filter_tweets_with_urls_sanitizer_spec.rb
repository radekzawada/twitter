RSpec.describe Infrastructure::Queries::Params::FilterTweetsWithUrlsSanitizer do
  describe '.sanitize!' do
    subject(:sanitizer) { described_class.new(default_filters, user_name) }
    let(:default_filters) { { :'-filter' => 'retweets', filter: 'links' } }
    let(:user_name) { 'user_name' }
    let(:params) { {} }
    let(:expected_result) { { filter: ['links'], from: [user_name], :'-filter' => ['retweets'] } }

    it 'returns params with filters' do
      sanitizer.sanitize! params
      expect(params).to eq(expected_result)
    end

    context 'when params already contains default filters' do
      let(:params) { { filter: ['links', 'some other value'] } }
      let(:expected_result) { { filter: ['links', 'some other value'], from: [user_name], :'-filter' => ['retweets'] } }

      it 'does not duplicate values' do
        sanitizer.sanitize! params
        expect(params).to eq(expected_result)
      end
    end

    context 'when user_name is nil' do
      let(:user_name) { nil }

      it 'raises exception' do
        expect { sanitizer.sanitize!(params) }.to raise_exception(Exceptions::WrongParameterException, 'USER_NAME parameter is not set')
      end
    end
  end
end
