require('./realm_royale/api/credential')

RSpec.describe RealmRoyale::Api::Credential do
  describe '.api_url' do
    it 'fetches the api url from ENV' do
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Credential::API_URL).and_return('https://dummyurl.com')
      expect(RealmRoyale::Api::Credential.api_url).to eq('https://dummyurl.com')
    end
  end

  describe '.api_key' do
    it 'fetches the api key from ENV' do
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Credential::API_KEY).and_return('dummy_api_key')
      expect(RealmRoyale::Api::Credential.api_key).to eq('dummy_api_key')
    end
  end

  describe '.dev_id' do
    it 'fetches the dev id from ENV' do
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Credential::API_DEV_ID).and_return('123')
      expect(RealmRoyale::Api::Credential.dev_id).to eq('123')
    end
  end
end