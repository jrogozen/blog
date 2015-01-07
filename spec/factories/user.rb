FactoryGirl.define do
  factory :user do
    email 'jonrogozen@gmail.com'
    name 'Jon Rogozen'
    password 'abcd12345' 
    password_confirmation { password }
    uid '1337'

    factory :confirmed_admin_user do
      confirmed_at Time.zone.now
      admin true
    end

    factory :confirmed_user do
      confirmed_at Time.zone.now
    end
  end
end