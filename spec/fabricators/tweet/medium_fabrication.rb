Fabricator(:medium) do
  url { Faker::Internet.url('tweeter.com') }
  type %w[url gif photo].sample
end
