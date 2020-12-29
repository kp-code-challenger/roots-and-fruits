require 'rails_helper'

class TestClient
  include HTTParty
  base_uri ENV.fetch('REGRESSION_URI', 'http://localhost:3000/')
end

RSpec.describe 'Specs that hit the actual API', type: :regression do
  after do
    sleep 0.5 # take it easy with my API keys
  end

  let(:path) { '/plants' }
  let(:query) { {} }
  let(:response) { TestClient.get(path, query: query) }

  context 'loads a list of over 200 edible plants' do
    it { expect(response['meta']['total']).to be > 200 }
  end

  context 'supports pagination' do
    let(:query) { { page: 2 } }

    it do
      expect(response['links']['self']).to include 'page=2'
      expect(response['links']['first']).to include 'page=1'
      expect(response['links']['next']).to include 'page=3'
    end
  end

  context 'searches for plants by name' do
    let(:query) { { filter: { common_name: 'rice' } } }

    it do
      expect(response['meta']['total']).to eq 1
      expect(response['data'].first['scientific_name']).to eq 'Oryza sativa'
    end
  end

  context 'loads specific data for a plant' do
    let(:path) { '/plants/176845' }

    it do
      expect(response['data']).to be_a Hash
      expect(response['data']['family_common_name']).to eq 'Buckwheat family'
    end
  end

  context 'finds plants in a specific region like British Columbia' do
    let(:query) { { filter: { zone_id: 'BRC' } } }

    it { expect(response['meta']['total']).to be > 30 }
  end

  context 'supports sorting' do
    let(:query) { { order: { growth_rate: :asc } } }

    it { expect(response['data'].map { |x| x['common_name'] }).to include 'Jerusalem artichoke' }
  end

  context 'can exclude certain filters' do
    let(:query) { { filter_not: { flower_color: 'red' } } }

    it { expect(response['data'].map { |x| x['family_common_name'] }).to include 'Pea family' }
  end
end
