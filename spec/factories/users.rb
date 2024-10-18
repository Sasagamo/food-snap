FactoryBot.define do
  factory :user do
    account_name             { Faker::Alphanumeric.alphanumeric(number: 8..16) } 
    nickname                 { Faker::Name.first_name.gsub(/\s/, '')[0..9] } 
    bio                      { Faker::Lorem.sentence(word_count: 10)[0..99] } 
    email                    { Faker::Internet.unique.email } 
    password                 { 'Password1' } 
    password_confirmation    {password}
    avatar                   { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/default_avatar.png'), 'image/png') } 

  end
end