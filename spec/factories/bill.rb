FactoryBot.define do
    factory :bill do
        association :user
        bill_name { "Chipotle Trip" }
    end
end