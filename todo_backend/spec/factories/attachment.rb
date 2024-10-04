FactoryBot.define do
    factory :attachment do
        to_do
        name { Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4) }
        data { Faker::String.random(length: 16..512) }
        end
    end
end
