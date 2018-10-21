# ERTweet

Welcome to er_tweet tool! It will help you to browse all hyperlinks from all tweets

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'er_tweet', git: 'https://github.com/radekzawada/twitter.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem specific_install https://github.com/radekzawada/twitter.git

## Dependencies

Ruby 2.5.2

## Variables

[required] TWITTER_API_CONSUMER_KEY => Your api consumer key from twitter api
[required] TWITTER_API_CONSUMER_SECRET => Your api consumer secret from twitter api
[required] TWITTER_USER_NAME => user name for search

## Usage

er_tweet filter_with_urls
OR
er_tweet filter_with_urls date_since
OR
er_tweet filter_with_urls date_since date_until

# result

|     params    |                 description                   |
|---------------|-----------------------------------------------|
| url           | address attached to tweet                     |
| type          | pointing on resource type                     |
| publisher     | tweet publisher                               |
| created_at    | publishing date                               |
| lang          | post language                                 |
| entities      | hastags(#), symbols($) and mentioned users(@) |
