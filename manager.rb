require 'uri'
require 'net/http'
require 'json'
require_relative 'coin'

class Manager
    @@repo={}
    def initialize()
        initialize_repo
    end

    def initialize_repo
        begin
            response = web_scrape
            json = JSON.parse(response)
            json.each do |symbol, value|
                @@repo[symbol] = Coin.new(symbol, value["USD"], value["EUR"], value["INR"])
            end
        rescue => exception
            puts "Error: #{exception}"
            exit 1 # exit with error
        end
    end

    def web_scrape
        url = "https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,SOL,USDT,DASH&tsyms=USD,EUR"
        uri = URI(url)
        Net::HTTP.get(uri)
    end

    def coin_list
        @@repo.keys
    end

    def calculate(symbol, amount, currency)
        coin = @@repo[symbol]
        amount * coin.send(currency.to_sym)
    end
end
