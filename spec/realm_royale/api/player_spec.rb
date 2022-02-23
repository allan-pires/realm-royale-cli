require('./realm_royale/api/player')

RSpec.describe RealmRoyale::Api::Player do
  describe '.valid_steam_ids' do
    it 'fetches the steam ids from ENV' do
      allow(ENV).to receive(:[]).with(RealmRoyale::Api::Player::API_STEAM_IDS).and_return('{"sample_username": 12345}')
      expect(RealmRoyale::Api::Player.valid_steam_ids).to eq({'sample_username' => 12345})
    end
  end
end