module RealmRoyale
  module Api
    class Credential
      API_URL = 'REALM_API_URL'
      API_KEY = 'REALM_API_KEY'
      API_DEV_ID = 'REALM_API_DEV_ID'

      def self.api_url
        @realm_api_url ||= ENV[API_URL]
      end

      def self.api_key
        @realm_api_key ||= ENV[API_KEY]
      end

      def self.dev_id
        @realm_dev_id ||= ENV[API_DEV_ID]
      end
    end
  end
end