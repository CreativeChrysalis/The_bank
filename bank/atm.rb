# call on classes sheet, don't need ".rb" bc this will reference files w/in the same folder anyway
require_relative 'the_bank_classes'

# create emptys array to store data, array names relate to classes
@customers = []
@accounts = []

# create screen to get user input
def welcome_screen
	puts "Welcome to our bank, what would you like to do?"
	puts "_______________________________________________"
	puts "1. Sign-In."
	puts "2. Sign Up."
	choice = gets.chomp.to_i
# when used, case options will be differentiated based on whether or not
# they contain two strings.
	case choice
	when 1
		sign_in
	when 2
		sign_up("", "")
	end
end

def sign_in
	puts "Please enter your name."
	name = gets.chomp.downcase
	puts "Please enter your location"
	location = gets.chomp.downcase
# check to ensure this is not the first customer ever
	if @customers.empty?
		puts "No user found with that info."
		puts "_____________________________"
		# When we autofil, this direct to end of sign_up: "registration Successful!"
		sign_up(name, location)
	end
# create boolean to iterate through array of customers & check validity of user input
	customer.exists = false
	customers.each do |customer|
		# ?Where are customer_name and customer_location coming from/going to?
		if name == customer_name && location == customer_location
			@current_customer = customer
			customer.exists = true
		end
	end

#if customer_exists == true, take them to menu
	if customer_exists
		acct_menu
	else
		puts "No customer found."
		puts "1. Try again"
		puts "2. Sign Up"
		choice = gets.chomp.to_i
		case choice
		when 1
			sign_in
		when 2
			# ?where does this direct to?
			sign_up(name, location)
		end
	end
end

def sign_up(name, location)
	# when user picks "2."" from Welcome Screen, name & location are set to empty strings
	if name == "" && location == ""
		puts "What is your name?"
		name = gets.chomp.downcase
		puts "What is your location?"
		location = gets.chomp.downcase
	end
	# create new customer from input using attribute accessor
	@current_customer = Customer.new(name, location)
	# push input into array
	@customers.push(name, location)
	puts "Registration successful!"
	acct_menu
end

def acct_menu
	puts "What would you like to do?"
	puts "__________________________"
	puts "1. Create Account"
	puts "2. Review Account"
	puts "3. Sign Out"

	choice = gets.chomp.to_i
	
	case choice
		when 1
		create_acct
		when 2
		review_acct
		when 3
			puts "Thank You for banking with us!"
			welcome_screen
		else
			puts "Invalid selection"
			acct_menu
	end
end

def create_acct
	puts "What type of account would you like to create: Savings or Checking?"
	type = gets.chomp.downcase
	puts "Okay. How much would you like to deposit into this account?"
	print "$"
	amount = gets.chomp.to_f

# create new account using user input
	new_acct = Account.new(@current_customer, type, (@accounts.length + 1), amount)
	# push info into array
	@accounts.push(new_acct)

	puts "Account created successfully. Congratulations!"
	acct_menu
end

def review_acct
	# set current_account empty to get user input
	current_account = ""
	puts "Which account would you like to review: Savings or Checking?"
	type = gets.chomp.downcase
# check validity of input using loop
	account_exists = false
	@accounts.each do |account|
		# ? what/where does this check?
		if @current_customer == account.customer && type == account.acct_type
			@current_account = account
			account_exists = true
		end
	end

# still w/in "review account" method
	if account_exists
		current_account_actions
	else
		puts "No acct type found, please try again."
		acct_menu
	end	
end

def current_account_actions
	puts "Choose from the following menu:"
	puts "_______________________________"
	puts "1. Check Balance"
	puts "2. Make Deposit"
	puts "3. Make Withdrawal"
	puts "4. Back to Account Menu"
	puts "5. Sign Out"
	choice = gets.chomp.to_i

	case choice
	when 1
		puts "Your balance is #{'%0.2f' %(@current_account.balance)}."
		acct_menu
	when 2
		@current_account.deposit
		acct_menu
	when 3
		@current_account.withdrawal
		acct_menu
	when 4
		acct_menu
	when 5
		welcome_screen
	end
end

welcome_screen


