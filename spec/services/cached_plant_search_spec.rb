require 'rails_helper'

RSpec.describe CachedPlantSearch, type: :service do
  let(:params) do
    {
      filter: {
        common_name: 'rice'
      }
    }
  end

  let(:service) { described_class.new(params) }

  let(:api_response) { double(:api_response, body: api_response_body, code: 200) }
  let(:api_response_body) { { id: 1234, common_name: 'Rice' }.to_json }

  let(:existing_search) do
    Search.create!(
      query: 'filter%5Bcommon_name%5D=rice&filter%5Bedible%5D=true&page=1',
      body: api_response_body
    )
  end

  it 'fetches an api response if none is cached' do
    expect(TrefleRequest).to receive(:get).and_return(api_response)

    expect { service.perform }.to change(Search, :count).by(1)

    expect(service.cached_response.body).to eq api_response_body
  end

  it 'returns a cached response if it exists' do
    existing_search

    expect(TrefleRequest).not_to receive(:get)

    expect { service.perform }.not_to change(Search, :count)

    expect(service.cached_response.body).to eq api_response_body
  end

  it 'always adds page=1 if not specified' do
    expect(TrefleRequest).to receive(:get).and_return(api_response)

    expect { service.perform }.to change(Search, :count).by(1)

    service = described_class.new(params.merge(page: 1))

    expect { service.perform }.not_to change(Search, :count)
  end

  it 'sorts the params so the order does not matter' do
    expect(TrefleRequest).to receive(:get).and_return(api_response)

    described_class.new({ page: 1 }.merge(params)).perform

    expect(Search.last.query).to eq existing_search.query
  end
end
