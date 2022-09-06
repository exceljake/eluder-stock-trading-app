FactoryBot.define do
  factory :user do
    email { ('a'..'z').to_a.shuffle.join + "@hh.ph" }
    role { "trader" }
    status { "pending" }
  end

  trait :skip_validate do
    to_create {|instance| instance.save(validate: false)}
  end

  trait :admin do
    role { "admin" }
    status { "approved" }
  end
end
