Fabricator(:tweet) do
  user
  created_at Faker::Time.between(DateTime.now - 7, DateTime.now)
  lang 'pl'
  url Faker::Internet.url('tweeter.com')
  urls(rand: 1..4)
  media(count: 3) { |_attrs, _i| Fabricate(:medium) }
  hashtags(rand: 1..3)
  symbols(rand: 1..3)
  user_mentions(rand: 1..3)
end
