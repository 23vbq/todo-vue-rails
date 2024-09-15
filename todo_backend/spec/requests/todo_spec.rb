require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let!(:todos) { create_list(:todo, 10) }

  # Create new todo
  describe "POST /todo" do
    let(:valid_attributes) {
      { 
        group_id: Faker::Number.between(from: 0, to: 10),
        priority: Faker::Number.between(from: 1, to: 5),
        date_planning: Faker::TIme.between(from: DateTime.now - 10, to: DateTime.now + 10),
        title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4),
        description: Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 4)
      }
    }

    context "request is valid" do
      before { post '/todo', params: valid_attributes }

      it "created has default values" do
        expect(json['status']).to eq(0)
        expect(json['date_creation']).to eq(DateTime.now)
      end

      it "created has user defined values" do
        expect(json['group_id']).to eq(valid_attributes['group_id'])
        expect(json['priority']).to eq(valid_attributes['priority'])
        expect(json['date_planning']).to eq(valid_attributes['date_planning'])
        expect(json['title']).to eq(valid_attributes['title'])
        expect(json['description']).to eq(valid_attributes['description'])
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end
end
