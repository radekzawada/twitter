require 'spec_helper.rb'

RSpec.describe ERTweet::CLI do
  describe '.filter_with_urls' do
    let(:dependencies_assembler) { Infrastructure::DependenciesAssembler.new }
    let(:twitter_client) { double(Twitter::REST::Client) }
    let(:friends_names) { %w[friend1 friend2 friend3] }
    let(:friends) { friends_names.map { |friend_name| double(screen_name: friend_name) } }
    let(:tweets) { Array.new(2) { Fabricate.build(:tweet) } }
    let(:query) { 'filter:links -filter:retweets from:user_name OR from:friend1 OR from:friend2 OR from:friend3' }

    before do
      allow(twitter_client).to receive(:friends) { friends }
      allow(twitter_client).to receive(:search).with(query) { tweets }
      allow(dependencies_assembler).to receive(:twitter_client) { twitter_client }
      allow(dependencies_assembler).to receive(:user_name) { 'user_name' }
      allow(subject).to receive(:dependencies_assembler) { dependencies_assembler }
    end

    it 'prints search results' do
      expect(STDOUT).to receive(:puts)
      subject.filter_with_urls
    end
  end
end
