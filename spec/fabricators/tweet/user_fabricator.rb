Fabricator(:user) do
  name Faker::Name.name
  screen_name Faker::Name.first_name
end
