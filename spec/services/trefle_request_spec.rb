require 'rails_helper'

RSpec.describe TrefleRequest, type: :service do
  let(:token) { SecureRandom.hex }
  let(:base_query) { { page: 2 } }
  let(:subject) { described_class.new('/plants', base_query) }
  let(:final_query) { base_query.merge(token: token) }
  let(:api_response) { double(:api_response, body: '{}', code: 200) }

  it 'appends an API token to the request' do
    expect(subject).to receive(:api_token).and_return token
    expect(TrefleRequest).to receive(:get).with('/plants', { query: final_query }).and_return(api_response)

    subject.perform
  end
end
