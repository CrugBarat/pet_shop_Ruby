require_relative('pet_shop_functions.rb')

def check_if_customer_by_name(customer_name)
  for customer in @customers
    if customer[:name] == customer_name
      return true
    break
    end
  end
end

def display_pets_instock(outputs)
  puts outputs[:current_stock]
  for pet in @pet_shop[:pets]
    puts outputs[:pet_details]
    puts pet
  end
  return_to_options(outputs)
end

def display_sold_pet(user)
  for customer in @customers
    if user == customer[:name]
      puts customer[:pets]
    end
  end
end

def check_if_pet_in_stock(pet_name)
  for pet in @pet_shop[:pets]
    if pet[:name] == pet_name
      return true
    break
    end
  end
end

def is_customer(outputs, customer_name)
  if check_if_customer_by_name(customer_name) == true
    return true
    puts outputs[:is_customer]
  else
    puts outputs[:not_customer]
  end
end

def is_customer_buy_sell(outputs, customer_name)
  if check_if_customer_by_name(customer_name) == true
    return true
  else
    puts outputs[:not_customer_buy_sell]
  end
end

def have_pet(outputs, pet_name)
  if check_if_pet_in_stock(pet_name) == true
    puts outputs[:pet_instock]
    return_to_options(outputs)
    return true
  else
    puts outputs[:pet_not_instock]
    return_to_options(outputs)
  end
end

def buy_pet(outputs, pet_name_input, customer_name_input, find_pet, find_customer)
  puts outputs[:security_buy]
  @buy_customer_name_input = gets.chomp.capitalize.to_s
  if is_customer_buy_sell(outputs, @buy_customer_name_input) == true
    puts outputs[:buy_pet_name]
    @buy_pet_name_input = gets.chomp.capitalize
    @find_pet = find_pet_by_name(@pet_shop, @buy_pet_name_input)
    @find_customer = find_customer_by_name(@buy_customer_name_input)
    if check_if_pet_in_stock(@buy_pet_name_input) == true
      if customer_can_afford_pet(@find_customer, @find_pet) == true
        sell_pet_to_customer(@pet_shop, @find_pet, @find_customer)
        puts outputs[:congratulations]
        puts outputs[:display_receipt_pet]
        display_sold_pet(@buy_customer_name_input)
        puts outputs[:balance]
        puts customer_cash(@find_customer)
        outputs[:return_to_options]
        return_to_options(outputs)
      else
        puts outputs[:insufficient_funds]
        return_to_options(outputs)
      end
    else
      puts outputs[:pet_not_instock]
      outputs[:return_to_options]
      return_to_options(outputs)
    end
  else
    buy_pet(outputs, pet_name_input, customer_name_input, find_pet, find_customer)
  end
end

def sign_in(outputs)
  puts outputs[:get_name]
  customer_name_input = gets.chomp.capitalize.to_s
  if is_customer(outputs, customer_name_input) == true
    puts outputs[:welcome]
    user_options(outputs)
  else
    register_customer(outputs)
  end
end

def register_customer(outputs)
  new_customer = Hash.new
  puts outputs[:get_new_user_name]
  user_name = gets.chomp.capitalize
  new_customer[:name] = user_name
  new_customer[:pets] = []
  puts outputs[:get_user_cash]
  user_cash = gets.chomp.capitalize
  new_customer[:cash] = user_cash.to_i()
  @customers.push(new_customer)
  user_options(outputs)
end

def user_options(outputs)
  puts outputs[:display_options]
  get_user_option = gets.chomp.to_i
  if get_user_option == 1
    display_pets_instock(outputs)
  elsif
    get_user_option == 2
    puts outputs[:get_pet]
    pet_name_input = gets.chomp.capitalize.to_s
    have_pet(outputs, pet_name_input)
  elsif
    get_user_option == 3
    buy_pet(outputs, @pet_name_input, @customer_name_input, @find_pet, @find_customer)
  elsif
    get_user_option == 4
    sell_pet_to_shop(outputs)
  elsif
    get_user_option == 5
    add_cash_to_account(outputs)
  else
    get_user_option == 6
    begin
      exit
    rescue SystemExit
      puts outputs[:farewell]
    end
  end
end

def return_to_options(outputs)
  puts outputs[:return_to_options]
  response = gets.chomp
  user_options(outputs)
end

def add_customer_cash(customer, cash_amount)
  customer[:cash] += cash_amount
end

def remove_shop_cash_to_cust(cash_amount)
   @pet_shop[:admin][:total_cash] -= cash_amount
end

def decrease_pets_sold(pet_amount)
  @pet_shop[:admin][:pets_sold] -= pet_amount
end

def display_receipt_pet_sell()
  @pet_shop[:pets][-1].map{ |k,v| "#{k} : #{v}" }.sort
end

def sell_pet_to_shop(outputs)
  sell_new_pet = Hash.new
  puts outputs[:security_sell]
  customer_sell = gets.chomp.capitalize
  find_customer_sell = find_customer_by_name(customer_sell)
  if is_customer_buy_sell(outputs, customer_sell) == true
    puts outputs[:new_pet_name]
    new_pet_name = gets.chomp.capitalize
    sell_new_pet[:name] = new_pet_name.to_s
    puts outputs[:new_pet_type]
    new_pet_type = gets.chomp .capitalize
    sell_new_pet[:pet_type] = new_pet_type.to_sym
    puts outputs[:new_pet_breed]
    new_pet_breed = gets.chomp.capitalize
    sell_new_pet[:breed] = new_pet_breed.to_s
    puts outputs[:new_pet_price]
    new_pet_price = gets.chomp.to_i
    sell_new_pet[:price] = new_pet_price
    @pet_shop[:pets].push(sell_new_pet)
    add_customer_cash(find_customer_by_name(customer_sell), new_pet_price)
    remove_shop_cash_to_cust(new_pet_price)
    decrease_pets_sold(1)
    puts outputs[:congratulations_sell]
    puts outputs[:display_receipt_pet]
    puts display_receipt_pet_sell()
    puts outputs[:balance]
    puts customer_cash(find_customer_sell)
    return_to_options(outputs)
  else
    sell_pet_to_shop(outputs)
  end
end

def add_cash_to_account(outputs)
  puts outputs[:security_add_cash]
  customer_add_cash = gets.chomp.capitalize
  if is_customer_buy_sell(outputs, customer_add_cash) == true
    puts outputs[:add_cash_to_account]
    add_cash = gets.chomp.to_i
    find_customer_cash = find_customer_by_name(customer_add_cash)
    add_customer_cash(find_customer_cash, add_cash)
    puts outputs[:balance]
    puts customer_cash(find_customer_cash)
    return_to_options(outputs)
  else
    add_cash_to_account(outputs)
  end
end

outputs = {
:get_name => "\nTo sign in, please enter your name:",
:get_pet => "\nTo check stock, please enter a pet name:",
:confirm_purchase => "\nWould you like to purchase this pet?",
:is_customer => "\nGood news. You are a customer!",
:not_customer => "\nWhoops! You are not a customer yet. Please register.",
:not_customer_buy_sell => "\nWhoops! You have incorrectly entered your name - please try again!",
:pet_instock => "\nGood news. Pet is in stock!",
:pet_not_instock => "\nBad news. Pet is out of stock!",
:buy_pet => "\nWould you like to purchase this pet? Y/N",
:try_another_pet => "\nPlease select another pet!",
:farewell => "\nThank you for visiting Camelot of Pets. Goodbye!\n\n",
:stock_check => "\nWould you like to check our current stock? Y/N",
:get_new_user_name => "\nTo register, please enter your name:",
:get_user_cash => "\nHow much would you like to spend on a new pet?",
:new_sign_in => "\nGreat - you are now registered.",
:display_options => "\nYou now have six options:\n\n1. Display Stock\n2. Check Stock by Pet Name\n3. Buy a Pet\n4. Sell a Pet\n5. Add Cash to Account\n6. Exit\n\nPlease pick a number:\n",
:display_stock => "Display Stock",
:welcome => "\nWelcome back - you are signed in!",
:return_to_options => "\nPress enter to return to the main menu:",
:security_buy => "\nFor security, please enter your name to buy a pet:",
:security_sell => "\nFor security, please enter your name to sell a pet:",
:security_add_cash => "\nFor security, please enter your name to add cash to your account:",
:buy_pet_name => "\nPlease enter the name of the pet you want to buy:",
:congratulations => "\nCongratulations! You have purchased a new pet!",
:new_pet_name => "\nWhat is the name of the pet you would like to sell?",
:new_pet_type => "\nWhat is the type of pet?",
:new_pet_breed => "\nWhat is the pet breed?",
:new_pet_price => "\nWhat is the pet price?",
:congratulations_sell => "\nCongratulations! You have sold your pet to Camelot of Pets!",
:display_receipt_pet => "\nReceipt:\n",
:insufficient_funds => "\nSorry you have insufficient funds. Please add cash to your account.",
:balance => "\nCash Balance:\n",
:add_cash_to_account => "\nHow much cash would you like to enter into your account?",
:pet_details => "\nPet Details:\n",
:current_stock => "\nCURRENT STOCK:\n",
}

File.open('/Users/user/ruby_projects/pet_shop/assets/logo.txt').each do |line|
  puts line
end

shop_name = @pet_shop[:name]
puts "\n        Welcome to #{shop_name}!"

sign_in(outputs)
