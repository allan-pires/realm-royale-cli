require 'spec_helper'
require './realm_royale/api/session'

RSpec.describe RealmRoyale::Api::Session do
  describe '.make_request' do
    let(:response) { RealmRoyale::Api::Session.make_request(endpoint, extra_path) }

    let(:dummy_api_url) { 'https://dummyurl.com' }
    let(:dummy_api_key) { 'dummy_api_key' }
    let(:dummy_api_dev_id) { '123' }
    let(:timestamp) { Time.now.utc.strftime('%Y%m%d%H%M%S') }
    let(:signature) { Digest::MD5.hexdigest(dummy_api_dev_id + endpoint + dummy_api_key + timestamp) }

    before do
      Timecop.freeze(Time.now)
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Credential::API_URL).and_return(dummy_api_url)
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Credential::API_KEY).and_return(dummy_api_key)
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Credential::API_DEV_ID).and_return(dummy_api_dev_id)
    end

    after do
      Timecop.return
    end

    context 'when endpoint is createsession' do
      let(:endpoint) { 'createsession' }
      let(:extra_path) { 'should_not_be_included' }
      let(:expected_uri) { URI("#{dummy_api_url}/#{endpoint}json/#{dummy_api_dev_id}/#{signature}/#{timestamp}") }
      
      before { stub_request(:get, expected_uri).to_return(status: 200, body: '{}') }

      it 'creates the URI correctly' do 
        expect(response.code).to eq '200'
      end
    end

    context 'when endpoint is different than createsession' do
      let(:endpoint) { 'another_endpoint' }
      let(:extra_path) { '/should_be_included' }
      let(:session_id) { 'ABC123' }
      let(:create_session_signature) { Digest::MD5.hexdigest(dummy_api_dev_id + 'createsession' + dummy_api_key + timestamp) }
      let(:create_session_uri) { URI("#{dummy_api_url}/createsessionjson/#{dummy_api_dev_id}/#{create_session_signature}/#{timestamp}") }
      
      let(:expected_uri) { URI("#{dummy_api_url}/#{endpoint}json/#{dummy_api_dev_id}/#{signature}/#{session_id}/#{timestamp}#{extra_path}") }
      
      before do 
        stub_request(:get, create_session_uri).to_return(status: 200, body: '{"session_id": "ABC123"}')
        stub_request(:get, expected_uri).to_return(status: 200, body: '{}')
      end

      it 'creates the URI correctly' do 
        expect(response.code).to eq '200'
        expect(response.body).to eq '{}'
      end
    end
  end
end