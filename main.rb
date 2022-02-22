require 'optparse'
require 'dotenv'
require 'pp'
require_relative('realm_royale/api/session')
require_relative('realm_royale/api/player')

Dotenv.load
OptionParser.new do |parser|
  parser.banner = "Usage: main.rb [options]"
  
  parser.on("-h", "--help", "Prints this help") do
    puts parser
  end

  parser.on('-p', '--player', 'Show player info') do
    pp RealmRoyale::Api::Player.fetch_stats(ARGV.first)
  end

  parser.on('-a', '--all-players', 'Show all players info') do
    pp RealmRoyale::Api::Player.fetch_all_stats
  end

  parser.on('-l', '--list', 'List valid players') do
    puts "List of valid players:"
    RealmRoyale::Api::Player.valid_steam_ids.keys.each do |player| 
      puts ' - ' + player.to_s
    end
  end
end.parse!
