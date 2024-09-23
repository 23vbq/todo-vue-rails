require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:group_id) { create(:group).id }

  let!(:todos) { create_list(:to_do, 10) }
  let(:todo_id) { todos.first.id.to_s }

  # Get list of todos
  describe "GET /todo?group_id" do

    it "returns properly count each group" do
      @groups = ToDo.group(:group_id).count
      @groups.each do |key, value|
        get '/todo?group_id=' + key.to_s
        expect(json).not_to be_empty
        expect(json.size).to eq(value)
        expect(response).to have_http_status(200)
      end
    end
  end

  # Get data of todo
  describe "GET /todo/:id" do

    context "id is valid =>" do
      let(:todo_test) { todos.first }
      before { get '/todo/' + todo_id }

      it "returns data" do
        expect(json['status']).to eq(todo_test[:status])
        expect(json['group_id']).to eq(todo_test[:group_id])
        expect(json['priority']).to eq(todo_test[:priority])
        expect(json['date_creation']).to eq(todo_test[:date_creation])
        expect(json['date_planning']).to eq(todo_test[:date_planning])
        expect(json['title']).to eq(todo_test[:title])
        expect(json['description']).to eq(todo_test[:description])
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "id is invalid =>" do
      before { get '/todo/-1' }

      it "not returning data" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

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
        status: Faker::Number.between(from: 0, to: 3),
        group_id: group_id,
        priority: Faker::Number.between(from: 1, to: 5),
        date_planning: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now + 10),
        title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4),
        description: Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 4)
      }
    }

    context "record exists" do
      before {
        @todos_count = ToDo.count
        put '/todo/' + todo_id, params: valid_attributes
      }

      it "updates record" do
        expect(response.body).to be_empty
      end

      it "same count of todos" do
        expect(ToDo.count).to eq(@todos_count)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Delete todo
  describe "DELETE /todo/:id" do
    before {
      @todos_count = ToDo.count
      delete '/todo/' + todo_id
    }

    it "returns status code 204" do
      expect(response).to have_http_status 204
    end

    it "changes count of todos" do
      expect(ToDo.count).to eq(@todos_count - 1)
    end
  end
end
