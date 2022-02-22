module RealmRoyale
  module Api
    class Credential
      def self.api_url
        @realm_api_url ||= ENV['REALM_API_URL']
      end

      def self.api_key
        @realm_api_key ||= ENV['REALM_API_KEY']
      end

      def self.dev_id
        @realm_dev_id ||= ENV['REALM_API_DEV_ID']
      end
    end
  end
end