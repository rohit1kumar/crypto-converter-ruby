require_relative 'manager'

def submenu(manager, currency)
    coin_list = Manager.new.coin_list
    puts coin_list.join(", ").center(50, "#")
    puts "Available coins"
    print "Enter the coin symbol: "
    symbol = gets.chomp.upcase
    print "Enter the amount: "
    amount = gets.chomp.to_i

    if coin_list.include? symbol
        result = Manager.new.calculate(symbol, amount, currency)
        puts "-".center(50, "-")
        puts "#{amount} #{symbol} = #{result} #{currency}"
        puts "-".center(50, "-")
    else
        puts "#{symbol} is not available".center(50, "*")
    end
end

def main
    loop do
        manager = Manager.new
        puts " Welcome to Crypto Converter! ".center(50, "#")
        puts "a) Convert to USD"
        puts "b) Convert to EUR"
        puts "c) Convert to INR"
        puts "q) Quit"
        print "Enter your choice: "
        choice = gets.chomp.downcase

        case choice
        when "a" then submenu(manager, "USD")
        when "b" then submenu(manager, "EUR")
        when "c" then submenu(manager, "INR")
        end
        break unless choice != "q"
    end
end

main
