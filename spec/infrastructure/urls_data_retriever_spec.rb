RSpec.describe Infrastructure::UrlsDataRetriever do
  describe '.retrieve' do
    let(:media) do
      [
        Fabricate.build(:url, url: 'http://tweeter.com/claudn', type: 'gif'),
        Fabricate.build(:url, url: 'http://tweeter.com/clauda', type: 'photo')
      ]
    end
    let(:urls) { [Fabricate.build(:url, url: 'http://tweeter.com/claud')] }
    let(:user) { Fabricate.build(:user, name: 'Lloyd Erdman', screen_name: 'Carmine') }
    let(:hashtags) { [Fabricate.build(:hashtag, text: 'omnis'), Fabricate.build(:hashtag, text: 'ut')] }
    let(:mentions) do
      [
        Fabricate.build(:user_mention, screen_name: 'dolorum'),
        Fabricate.build(:user_mention, screen_name: 'facilis')
      ]
    end
    let(:symbols) { [Fabricate.build(:symbol, text: 'consectetur')] }
    let(:tweets) do
      [
        Fabricate.build(
          :tweet,
          created_at: Time.at(1_439_232_400),
          lang: 'pl',
          url: 'http://tweeter.com/santos.strosin',
          media: media,
          urls: urls,
          user: user,
          hashtags: hashtags,
          user_mentions: mentions,
          symbols: symbols
        )
      ]
    end
    let(:expected_result) do
      [
        {
          created_at: Time.at(1_439_232_400).strftime('%Y-%m-%d %H:%M:%S'),
          entities: ['#omnis', '#ut', '@dolorum', '@facilis', '$consectetur'],
          lang: 'pl',
          tweet_url: 'http://tweeter.com/santos.strosin',
          urls: [
            { url: 'http://tweeter.com/claud', type: 'hyperlink' },
            { url: 'http://tweeter.com/claudn', type: 'gif' },
            { url: 'http://tweeter.com/clauda', type: 'photo' }
          ],
          user: 'Carmine'
        }
      ]
    end

    it 'returns info about urls in tweets' do
      expect(subject.retrieve(tweets)).to eq(expected_result)
    end
  end
end
