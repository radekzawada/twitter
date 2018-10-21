RSpec.describe Infrastructure::Queries::Params::DateValidator do
  describe '.valid?' do
    context 'when date has proper format' do
      let(:date) { '2010-11-23' }

      it 'returns true' do
        expect(subject.valid?(date)).to be_truthy
      end
    end

    context 'when date has wrong format' do
      let(:date) { 'wrong date format' }

      it 'returns false' do
        expect(subject.valid?(date)).to be_falsey
      end
    end
  end

  describe '.valid_order?' do
    context 'when order is proper' do
      let(:since_date) { '2018-11-10' }
      let(:until_date) { '2018-11-15' }

      it 'returns true' do
        expect(subject.valid_order?(since_date, until_date)).to be_truthy
      end
    end

    context 'when order is not proper' do
      let(:since_date) { '2018-11-15' }
      let(:until_date) { '2018-11-10' }

      it 'returns false' do
        expect(subject.valid_order?(since_date, until_date)).to be_falsey
      end
    end
  end
end
