require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/film.rb')
require('pry')

Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({'name' => 'Lily', 'funds' => 10})
customer2 = Customer.new({'name' => 'Cameron', 'funds' => 20})
customer3 = Customer.new({'name' => 'Isobel', 'funds' => 35})

customer1.save
customer2.save
customer3.save

film1 = Film.new({'title' => 'T2 Trainspotting', 'price' => 15})
film2 = Film.new({'title' => 'Lion', 'price' => 10})
film3 = Film.new({'title' => 'Manchester by the Sea', 'price' => 20})

film1.save
film2.save
film3.save

ticket1 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket2 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save

binding.pry
nil