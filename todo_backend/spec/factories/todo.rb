FactoryBot.define do
  factory :to_do do
    status { Faker::Number.between(from: 0, to: 3) }
    group
    priority { Faker::Number.between(from: 1, to: 5) }
    date_creation { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now) }
    date_planning { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 10) }
    title { Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4) }
    description { Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 4) }
  end
end
