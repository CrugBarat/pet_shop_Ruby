require_relative('pet_shop_data.rb')

def pet_shop_name(pet_shop)
  pet_shop[:name]
end

def total_cash(pet_shop)
  pet_shop[:admin][:total_cash]
end

def add_or_remove_cash(pet_shop, cash_amount)
   pet_shop[:admin][:total_cash] += cash_amount
end

def pets_sold(pet_shop)
  pet_shop[:admin][:pets_sold]
end

def increase_pets_sold(pet_shop, pet_amount)
  pet_shop[:admin][:pets_sold] += pet_amount
end

def stock_count(pet_shop)
  pet_shop[:pets].length()
end

def pets_by_breed(pet_shop, pet_name)
  breed_total = []
  for pet in pet_shop[:pets]
    if pet[:breed] == pet_name
      breed_total.push(1)
    end
  end
  return breed_total
end

def find_pet_by_name(pet_shop, pet_name)
  for pet in pet_shop[:pets]
    if pet[:name] == pet_name
      return pet
    end
  end
  return nil
end

def find_customer_by_name(customer_name)
  for customer in @customers
    if customer_name == customer[:name]
      return customer
    end
  end
end

def remove_pet_by_name(pet_shop, pet_name)
  for pet in pet_shop[:pets]
    if pet_name == pet[:name]
      pet_shop[:pets].delete_if { |h| h[:name] == pet_name }
    end
  end
end

def add_pet_to_stock(pet_shop, new_pet)
  pet_shop[:pets].push(new_pet).length()
end

def customer_cash(customer)
  customer[:cash]
end

def remove_customer_cash(customer, cash_amount)
  customer[:cash] -= cash_amount
end

def customer_pet_count(customer)
  customer[:pets].length()
end

def add_pet_to_customer(customer, new_pet)
  customer[:pets].push(new_pet)
end

def customer_can_afford_pet(customer, new_pet)
  pet_price = new_pet[:price]
  customer[:cash] >= pet_price
end

def sell_pet_to_customer(pet_shop, pet, customer)
  if pet && customer_can_afford_pet(customer, pet)
    add_pet_to_customer(customer, pet)
    increase_pets_sold(pet_shop, 1)
    remove_customer_cash(customer, pet[:price])
    add_or_remove_cash(pet_shop, pet[:price])
    remove_pet_by_name(pet_shop, pet[:name])
  end
end
