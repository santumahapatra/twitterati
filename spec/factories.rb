FactoryGirl.define do
  factory :user do
    email "random@random.com"
    password "totallyrandom"
  end

  factory :tweet do
    content "Super Random"
    user
  end
end