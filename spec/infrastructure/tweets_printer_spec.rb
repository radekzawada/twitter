RSpec.describe Infrastructure::TweetsPrinter do
  describe '.print' do
    let(:urls_list) { ['www.foo.com'] }
    let(:expected_result) { urls_list.to_s }

    it 'prints response' do
      expect(subject).to receive(:puts).with(expected_result)
      subject.print(urls_list)
    end
  end
end
