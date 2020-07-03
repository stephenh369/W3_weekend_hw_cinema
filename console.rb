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





# SAVES TO DB
customer1.save()

# UPDATES TO DB
# customer1.funds = 100
# customer1.update()

# DELETES TO SINGLE ENTRIES
# customer1.delete()

binding.pry
nil