require 'rails_helper'

RSpec.describe '/plants', type: :request do
  let(:valid_attributes) {
    {
      query: '?someting',
      body: '{}'
    }
  }

  describe 'GET /plants' do
    it 'renders a successful response' do
      Search.create! valid_attributes
      get plants_url, headers: {}, as: :json
      expect(response).to be_successful
    end
  end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     search = Search.create! valid_attributes
  #     get plants_url(search), as: :json
  #     expect(response).to be_successful
  #   end
  # end
end
