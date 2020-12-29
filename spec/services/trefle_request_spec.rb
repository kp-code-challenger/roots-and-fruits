require 'rails_helper'

RSpec.describe TrefleRequest, type: :service do
  let(:token) { SecureRandom.hex }
  let(:base_query) { { page: 2 } }
  let(:subject) { TrefleRequest.new('/plants', base_query) }
  let(:final_query) { base_query.merge(token: token) }

  it 'should append an API token to the request' do
    expect(subject).to receive(:api_token).and_return token
    expect(TrefleRequest).to receive(:get).with('/plants', { query: final_query })

    subject.perform
  end
end
