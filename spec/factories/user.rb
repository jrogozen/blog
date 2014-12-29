FactoryGirl.define do
  factory :user do
    email 'jonrogozen@gmail.com'
    password 'abcd12345' 
    password_confirmation { password }

    factory :confirmed_user do
      confirmed_at Time.zone.now
    end
  end
end