# DEPENDANCIES
require('pry-byebug')

require_relative('models/Customer')
require_relative('models/Film')
require_relative('models/Ticket')

# OBJECTS
customer1 = Customer.new({
    'name' => 'Stephen',
    'funds' => 50
})
customer2 = Customer.new({
    'name' => 'Erin',
    'funds' => 100
})


film1 = Film.new({
    'title' => 'The Fast And The Furious',
    'price' => 12
})
film2 = Film.new({
    'title' => 'Blade Runner 2049',
    'price' => 15
})



# SAVES TO DB
customer1.save()
customer2.save()

film1.save()
film2.save()


# UPDATES TO DB
# customer1.funds = 100
# customer1.update()

# film1.price = 15
# film1.update()


# DELETES TO SINGLE ENTRIES
# customer1.delete()
# film1.delete()

binding.pry
nil