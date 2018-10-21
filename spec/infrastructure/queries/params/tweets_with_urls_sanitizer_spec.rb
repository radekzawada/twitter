RSpec.describe Infrastructure::Queries::Params::TweetsWithUrlsSanitizer do
  describe '.sanitize!' do
    subject(:sanitizer) { described_class.new(default_filters, user_name, date_validator: date_validator) }
    let(:default_filters) { { '-filter': 'retweets', filter: 'links' } }
    let(:date_validator) { double(Infrastructure::Queries::Params::DateValidator) }
    let(:user_name) { 'user_name' }
    let(:params) { { from: [user_name] } }
    let(:expected_date) { {} }
    let(:expected_result) do
      { filter: ['links'], from: [user_name], '-filter': ['retweets'] }
        .merge(expected_date)
    end

    context 'when params are empty' do
      let(:params) { {} }

      it 'returns params with default filters' do
        sanitizer.sanitize! params
        expect(params).to eq(expected_result)
      end
    end

    context 'when params already contain default filters' do
      let(:params) { { filter: ['links', 'some other value'] } }
      let(:expected_result) { { filter: ['links', 'some other value'], from: [user_name], '-filter': ['retweets'] } }

      it 'does not duplicate values' do
        sanitizer.sanitize! params
        expect(params).to eq(expected_result)
      end
    end

    context 'when user_name is nil' do
      let(:user_name) { nil }

      it 'raises exception' do
        expect { sanitizer.sanitize!(params) }.to(
          raise_exception(Exceptions::NilParameterException, 'TWITTER_USER_NAME system variable is not set')
        )
      end
    end

    context 'when params have additional parameters' do
      let(:params) { { from: %w[user_name friend1], additional_param: ['val'] } }
      let(:expected_result) { { filter: ['links'], from: %w[user_name friend1], '-filter': ['retweets'] } }

      it 'removes additional params' do
        sanitizer.sanitize! params
        expect(params).to eq(expected_result)
      end
    end

    context 'when params include until params' do
      let(:params) { { since: '2018-11-01' } }
      let(:expected_date) { { since: '2018-11-01' } }

      it 'returns until param' do
        expect(date_validator).to receive(:valid?).with('2018-11-01') { true }
        sanitizer.sanitize! params
        expect(params).to eq(expected_result)
      end
    end

    context 'when params include until and since params' do
      let(:params) { { since: '2018-11-01', until: '2018-12-01' } }
      let(:expected_date) { { since: '2018-11-01', until: '2018-12-01' } }

      it 'returns date params' do
        expect(date_validator).to receive(:valid?).with('2018-12-01') { true }
        expect(date_validator).to receive(:valid?).with('2018-11-01') { true }
        expect(date_validator).to receive(:valid_order?).with('2018-11-01', '2018-12-01') { true }
        sanitizer.sanitize! params
        expect(params).to eq(expected_result)
      end

      context 'when until is before since' do
        let(:params) { { since: '2018-12-01', until: '2018-11-01' } }

        it 'raises wrong parameter exception' do
          expect(date_validator).to receive(:valid?).with('2018-12-01') { true }
          expect(date_validator).to receive(:valid?).with('2018-11-01') { true }
          expect(date_validator).to receive(:valid_order?).with('2018-12-01', '2018-11-01') { false }
          error_msg = 'until_date cannot be before since_date'
          expect { sanitizer.sanitize!(params) }.to raise_exception(Exceptions::WrongParameterException, error_msg)
        end
      end
    end

    context 'when date has wrong format' do
      let(:params) { { since: '11-2018-01' } }

      it 'raises wrong parameter exception' do
        expect(date_validator).to receive(:valid?) { false }
        error_msg = 'wrong date format, should be YYYY-MM-DD'
        expect { sanitizer.sanitize!(params) }.to raise_exception(Exceptions::WrongParameterException, error_msg)
      end
    end
  end
end
