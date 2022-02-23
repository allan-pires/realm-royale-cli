require 'uri'
require 'net/http'
require 'digest'
require 'json'
require_relative('credential')

module RealmRoyale
  module Api
    class Session
      def initialize
        create_session
      end

      def make_request(endpoint, extra_path = '')
        uri = create_uri(endpoint, extra_path)
        Net::HTTP.get_response(uri)
      end

      private

      def create_uri(endpoint, extra_path)
        signature = create_api_signature(endpoint)

        if endpoint == 'createsession'
          URI("#{RealmRoyale::Api::Credential.api_url}/#{endpoint}json/#{RealmRoyale::Api::Credential.dev_id}/#{signature}/#{timestamp}")
        else
          URI("#{RealmRoyale::Api::Credential.api_url}/#{endpoint}json/#{RealmRoyale::Api::Credential.dev_id}/#{signature}/#{session_id}/#{timestamp}#{extra_path}")
        end
      end

      def create_api_signature(endpoint)
        Digest::MD5.hexdigest(RealmRoyale::Api::Credential.dev_id + endpoint + RealmRoyale::Api::Credential.api_key + timestamp)
      end

      def session_id
        @session_id ||= create_session
      end

      def timestamp
        Time.now.utc.strftime('%Y%m%d%H%M%S')
      end

      def create_session
        response = make_request('createsession')
        @session_id = JSON.parse(response.body)['session_id']
        @session_id
      end
    end
  end
end