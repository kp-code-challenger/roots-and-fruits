require 'rails_helper'

RSpec.describe '/plants', type: :request do
  let(:search_attributes) do
    {
      query: '?page=1',
      body: '{}'
    }
  end

  let(:valid_search) { Search.create!(search_attributes) }

  let(:mock_api_response) { double(:api_response, body: '{}', code: 200) }

  describe 'GET /plants' do
    before do
      valid_search
    end

    it 'renders a successful response' do
      expect_any_instance_of(TrefleRequest).to receive(:perform).and_return(mock_api_response)

      get plants_url(page: 1)

      expect(response).to be_successful
    end

    it 'returns an error if invalid params are given' do
      get plants_url(pagez: 1)

      expect(response).to have_http_status :unprocessable_entity

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['error']).to be true
      expect(parsed_response['message']).to include 'unpermitted parameter'
    end
  end
end
