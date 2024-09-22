require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:group_id) { create(:group).id }

  let!(:todos) { create_list(:to_do, 10) }
  let(:todo_id) { todos.first.id.to_s }

  # Create new todo
  describe "POST /todo" do
    let(:valid_attributes) {
      { 
        group_id: group_id,
        priority: Faker::Number.between(from: 1, to: 5),
        date_planning: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 10),
        title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4),
        description: Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 4)
      }
    }

    context "request is valid =>" do
      before { 
        @todos_count = ToDo.count
        post '/todo', params: valid_attributes 
      }

      it "created has default values" do
        expect(json['status']).to eq(0)
        expect(json['date_creation']).to be > (DateTime.now - 1).utc.iso8601(3) # eq(DateTime.now.utc.iso8601(3))
      end

      it "created has user defined values" do
        expect(json['group_id']).to eq(valid_attributes[:group_id])
        expect(json['priority']).to eq(valid_attributes[:priority])
        expect(json['date_planning']).to eq(valid_attributes[:date_planning].change(sec: valid_attributes[:date_planning].sec).utc.iso8601(3))
        expect(json['title']).to eq(valid_attributes[:title])
        expect(json['description']).to eq(valid_attributes[:description])
      end

      it "changes count of todos" do
        expect(ToDo.count).to eq(@todos_count + 1)
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "request is invalid =>" do
      let(:todos_count) { ToDo.count }
      before { post '/todo', params: {} }

      it "same count of todos" do
        expect(ToDo.count).to eq(todos_count)
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Update existing todo
  describe "PUT /todo/:id" do
    let(:valid_attributes) {
      { 
        group_id: Faker::Number.between(from: 1, to: 10),
        priority: Faker::Number.between(from: 1, to: 5),
        date_planning: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 10),
        title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4),
        description: Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 4)
      }
    }

    context "record exists" do
      let(:todos_count) { ToDo.count }
      before { put '/todo/' + todo_id, params: valid_attributes }

      it "updates record" do
        expect(response.body).to be_empty
      end

      it "same count of todos" do
        expect(ToDo.count).to eq(todos_count)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Delete todo
  describe "DELETE /todo/:id" do
    let(:todos_count) { ToDo.count }
    before { delete '/todo/' + todo_id }

    it "returns status code 204" do
      expect(response).to have_http_status 204
    end

    it "changes count of todos" do
      expect(ToDo.count).to eq(todos_count - 1)
    end
  end
end
