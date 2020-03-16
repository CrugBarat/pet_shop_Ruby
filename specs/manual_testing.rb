  @customers = [
    {
      name: "Alice",
      pets: [],
      cash: 1000
    },
    {
      name: "Bob",
      pets: [],
      cash: 50
    },
    {
      name: "Jack",
      pets: [],
      cash: 100
    }
  ]

  @new_pet = {
    name: "Bors the Younger",
    pet_type: :cat,
    breed: "Cornish Rex",
    price: 100
  }

  @pet_shop = {
    pets: [
      {
        name: "Sir Percy",
        pet_type: :cat,
        breed: "British Shorthair",
        price: 500
      },
      {
        name: "King Bagdemagus",
        pet_type: :cat,
        breed: "British Shorthair",
        price: 500
      },
      {
        name: "Sir Lancelot",
        pet_type: :dog,
        breed: "Pomsky",
        price: 1000,
      },
      {
        name: "Arthur",
        pet_type: :dog,
        breed: "Husky",
        price: 900,
      },
      {
        name: "Tristan",
        pet_type: :dog,
        breed: "Basset Hound",
        price: 800,
      },
      {
        name: "Merlin",
        pet_type: :cat,
        breed: "Egyptian Mau",
        price: 1500,
      }
    ],
    admin: {
      total_cash: 1000,
      pets_sold: 0,
    },
    name: "Camelot of Pets"
 }

def pet_shop_name(pet_shop)
  pet_shop[:name]
end

p pet_shop_name(@pet_shop)


def total_cash(pet_shop)
  pet_shop[:admin][:total_cash]
end

p total_cash(@pet_shop)


def add_or_remove_cash(pet_shop, cash_amount)
   pet_shop[:admin][:total_cash] += cash_amount
end

p add_or_remove_cash(@pet_shop, 225)
p add_or_remove_cash(@pet_shop, -374)


def pets_sold(pet_shop)
  pet_shop[:admin][:pets_sold]
end

p pets_sold(@pet_shop)


def increase_pets_sold(pet_shop, pet_amount)
  pet_shop[:admin][:pets_sold] += pet_amount
end

p increase_pets_sold(@pet_shop, 8)
p increase_pets_sold(@pet_shop, 55)


def stock_count(pet_shop)
  pet_shop[:pets].length()
end

p stock_count(@pet_shop)


def pets_by_breed(pet_shop, pet_name)
  @breed_total = []
  for pet in pet_shop[:pets]
    if pet[:breed] == pet_name
      @breed_total.push(1)
    end
  end
  return @breed_total
end

pets_by_breed(@pet_shop, "British Shorthair")
p @breed_total.count()
pets_by_breed(@pet_shop, "Husky")
p @breed_total.count()
pets_by_breed(@pet_shop, "Kangaroo")
p @breed_total.count()


def find_pet_by_name(pet_shop, pet_name)
  for pet in pet_shop[:pets]
    if pet[:name] == pet_name
      return pet
    end
  end
  return nil
end

p find_pet_by_name(@pet_shop, "Arthur")[:name]
p find_pet_by_name(@pet_shop, "Merlin")[:name]
p find_pet_by_name(@pet_shop, "Fred")
p find_pet_by_name(@pet_shop, "Bob")



def remove_pet_by_name(pet_shop, pet_name)
  for pet in pet_shop[:pets]
    if pet_name == pet[:name]
      pet_shop[:pets].delete_if { |h| h[:name] == pet_name }
    end
  end
end

remove_pet_by_name(@pet_shop, "Arthur")
p @pet_shop[:pets]
remove_pet_by_name(@pet_shop, "Merlin")
p @pet_shop[:pets]
remove_pet_by_name(@pet_shop, "Sir Percy")
p @pet_shop[:pets]


def add_pet_to_stock(pet_shop, new_pet)
  pet_shop[:pets].push(new_pet).length()
end

add_pet_to_stock(@pet_shop, @new_pet)
p @pet_shop[:pets]
p @pet_shop[:pets].length()


def customer_cash(customer)
  customer[:cash]
end

p customer_cash(@customers[0])
p customer_cash(@customers[2])


def remove_customer_cash(customer, cash_amount)
  customer[:cash] -= cash_amount
end

p remove_customer_cash(@customers[0], 45)
p remove_customer_cash(@customers[2], 99)


def customer_pet_count(customer)
  customer[:pets].length()
end

p customer_pet_count(@customers[0])
p customer_pet_count(@customers[2])


def add_pet_to_customer(customer, new_pet)
  customer[:pets].push(new_pet)
end

p add_pet_to_customer(@customers[0], @new_pet)
p add_pet_to_customer(@customers[2], @new_pet)


def customer_can_afford_pet(customer, new_pet)
  @pet_price = new_pet[:price]
  customer[:cash] >= @pet_price
end

p customer_can_afford_pet(@customers[1], @new_pet)
p customer_can_afford_pet(@customers[0], @new_pet)

def sell_pet_to_customer(pet_shop, pet, customer)
  if pet && customer_can_afford_pet(customer, pet)
    add_pet_to_customer(customer, pet)
    increase_pets_sold(pet_shop, 1)
    remove_customer_cash(customer, pet[:price])
    add_or_remove_cash(pet_shop, pet[:price])
    remove_pet_by_name(pet_shop, pet[:name])
  end
end

sell_pet_to_customer(@pet_shop, find_pet_by_name(@pet_shop,"King Bagdemagus"), @customers[0])
p @customers
p @pet_shop
p sell_pet_to_customer(@pet_shop, find_pet_by_name(@pet_shop,"Sir Percy"), @customers[1])
p @customers
p @pet_shop
