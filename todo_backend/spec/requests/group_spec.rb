require 'rails_helper'

RSpec.describe "Groups", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end
  let!(:groups) { create_list(:group, 10) }
  let(:group_id) { groups.first.id }

  # Get list of groups
  describe "GET /groups" do
    before { get '/groups' }

    it 'returns groups' do
      expect(json).not_to_be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Create new group
  describe "POST /groups" do
    let(:valid_attributes) { { name: 'Group' } }

    context "request is valid" do
      before { post '/groups', params: valid_attributes }

      it "creates a group" do
        expect(json['name']).to eq('Group')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
    
    context "request is invalid" do
      before { post '/groups', params: {} }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns validation presence failure" do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Name can't be blank\"}")
      end
    end
    # TODO other validations
  end

  # Update existing group
  describe "PUT /groups/:id" do
    let(:valid_attributes) { { name: 'Tasks' } }

    context "record exists" do
      before { put '/groups/#{group_id}', params: valid_attributes }

      it "updates record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Delete group
  describe "DELETE /groups/:id" do
    before { delete '/groups/#{group_id}' }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
