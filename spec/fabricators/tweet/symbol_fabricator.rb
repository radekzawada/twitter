Fabricator(:symbol, from: :symbol_tweet) do
  text { Faker::Lorem.word }
end
