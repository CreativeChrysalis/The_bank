class Customer
	attr_accessor :name, :location
	
	def initialize(name, location)
		@name = name
		@location = location
	end
end

class Account

	attr_accessor :customer, :acct_type
	attr_reader :acct_number, :balance

	def initialize (customer, acct_type, acct_number, balance)
		@customer = customer
		@acct_type = acct_type
		@acct_number = acct_number
		@balance = balance
	end

	def deposit 
		puts "How much would you like to deposit?"
		puts "$"
		amount = gets.chomp.to_f
		balance += amount
		puts "Your new balance is #{'%0.2f' %(@balance)}"
	end

	def withdrawal
		puts "How much would you like to withdrawal?"
		puts "$"
		amount = gets.chomp.to_f
		if balance < amount
			balance -= (amount +25)
		else
			balance -= amount
		end
		puts "Your new balance is #{'%0.2f' %(@balance)}"
	end
	
end


