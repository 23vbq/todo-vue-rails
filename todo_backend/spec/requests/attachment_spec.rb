require 'rails_helper'

RSpec.describe "Attachments", type: :request do
  let(:todo_id) { create(:to_do).id }

  let!(:attachments) { create_list(:attachment, 10) }
  let(:attachment_id) { attachments.first.id.to_s }

  # Get list of attachments
  describe "GET /attachment?to_do_id" do
    it "returns properly count each todo" do
      @todos = Attachment.group(:to_do_id).count
      @todos.each do |key, value|
        get '/attachment?to_do_id=' + key.to_s
        expect(json).not_to be_empty
        expect(json.size).to eq(value)
        expect(response).to have_http_status(200)
      end
    end
  end

  # Get data of attachment
  describe "GET /attachment/:id" do
    context "id is valid =>"  do
      let(:attachment_test) { attachments.first }
      before { get '/attachment/' + attachment_id }

      it "returns data" do
        expect(json['id']).to eq(attachment_test.id)
        expect(json['name']).to eq(attachment_test[:name])
        expect(json['data']).to eq(attachment_test[:data])
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "id is invalid =>" do
      before { get '/attachment/-1' }

      it "returns cannot find" do
        expect(response.body)
          .to match("{\"message\":\"Couldn't find Attachment with 'id'=" + (-1).to_s + "\"}")
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Create new attachment
  describe "POST /attachment" do
    let(:valid_attributes) {
      {
        to_do_id: todo_id,
        name: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4),
        data: Faker::String.random(length: 16..512)
      }
    }

    context "request is valid =>" do
      before {
        @attachments_count = Attachment.count
        post '/attachment', params: valid_attributes
      }

      it "created attachment has user defined values" do
        expect(json['to_do_id']).to eq(valid_attributes[:to_do_id])
        expect(json['name']).to eq(valid_attributes[:name])
        expect(json['data']).to eq(valid_attributes[:data])
      end

      it "changes count of attachments" do
        expect(Attachment.count).to eq(@attachments_count + 1)
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "request is invalid =>" do
      before {
        @attachments_count = Attachment.count
        post '/attachment', params: {}
      }

      it "same count of attachments" do
        expect(Attachment.count).to eq(@attachments_count)
      end

      it "retruns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Update existing attachment
  describe "PUT /attachment/:id" do
    let(:valid_attributes) {
      {
        name: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4)
      }
    }

    context "record exists" do
      before {
        @attachments_count = Attachment.count;
        put '/attachment/' + attachment_id, params: valid_attributes
      }

      it "updates record" do
        expect(response.body).to be_empty
        expect(Attachment.find(attachment_id).name).to eq(valid_attributes[:name])
      end

      it "same count of records" do
        expect(Attachment.count).to eq(@attachments_count)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Delete attachment
  describe "DELETE /attachment/:id" do
    before {
      @attachments_count = Attachment.count
      delete '/attachment/' + attachment_id
    }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end

    it "changes count of records" do
      expect(Attachment.count).to eq(@attachments_count - 1)
    end
  end
end
