# DEPENDANCIES
require('pry-byebug')

require_relative('models/Customer')
require_relative('models/Film')
require_relative('models/Ticket')

# RESET DB - DELETE ALL ENTRIES
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()



# OBJECTS
customer1 = Customer.new({
    'name' => 'Stephen',
    'funds' => 50
})
customer2 = Customer.new({
    'name' => 'Erin',
    'funds' => 100
})
customer1.save()
customer2.save()


film1 = Film.new({
    'title' => 'The Fast And The Furious',
    'price' => 12
})
film2 = Film.new({
    'title' => 'Blade Runner 2049',
    'price' => 15
})
film1.save()
film2.save()


# ticket1 = Ticket.new({
#     'customer_id' => customer1.id,
#     'film_id' => film1.id
# })
# ticket2 = Ticket.new({
#     'customer_id' => customer2.id,
#     'film_id' => film1.id
# })
# ticket1.save()
# ticket2.save()



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