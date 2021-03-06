require 'thread'
require_relative('session')

module RealmRoyale
  module Api
    class Player
      API_STEAM_IDS = 'VALID_STEAM_IDS'

      def self.fetch_all_stats
        api_session
        players = valid_steam_ids.keys
        status = {}
        
        threads = []
        players.each do |player|
          threads << Thread.new { status[player] = fetch_stats(player) }
        end
        threads.each(&:join)
        
        status
      end

      def self.fetch_stats(player_name)
        puts "Checking status for #{player_name}..."

        player_steam_id = valid_steam_ids[player_name]
        return 'Please enter a valid player name.' unless player_steam_id

        player_id = fetch_info(player_steam_id)['id']
        return 'Failed to fetch player info.' unless player_id > 0

        aggregate_stats = fetch_aggregated_stats(player_id)
        return 'Failed to fetch player stats.' unless aggregate_stats

        aggregate_stats.slice(:games_played, :wins, :losses, :kills_player, :deaths, :average_placement)
      end

      def self.valid_steam_ids
        @valid_steam_ids ||= JSON.parse(ENV['VALID_STEAM_IDS'])
      end

      private

      def self.fetch_info(player_steam_id)
        response = api_session.make_request('getplayer', "/#{player_steam_id}/steam")
        JSON.parse(response.body)
      end

      def self.fetch_aggregated_stats(player_id)
        response = api_session.make_request('getplayerstats', "/#{player_id}")
        json_response = JSON.parse(response.body)&.transform_keys(&:to_sym)
        json_response[:aggregate_stats]&.transform_keys(&:to_sym)
      end

      def self.api_session
        @api_session ||= RealmRoyale::Api::Session.new
      end
    end
  end
end