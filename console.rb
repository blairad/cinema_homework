require_relative('./models/customer')
require_relative('./models/tickets')
require_relative('./models/films')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()



customer1 = Customer.new( { 'name' => 'Paulie', 'funds' => 100})
customer2 = Customer.new( { 'name' => 'Silvio', 'funds' => 800})
customer3 = Customer.new( { 'name' => 'Christopher', 'funds' => 700})
customer4 = Customer.new( { 'name' => 'Junior', 'funds' => 900})
customer5 = Customer.new( { 'name' => 'Ralphie', 'funds' => 700})
customer6 = Customer.new( { 'name' => 'Tony', 'funds' => 1000})

film1 = Film.new( { 'title' => 'Godfather', 'price' => 15})
film2 = Film.new( { 'title' => 'The Untouchables', 'price' => 10})
film3 = Film.new( { 'title' => 'Goodfellas', 'price' => 12})
film4 = Film.new( { 'title' => 'Gladiator', 'price' => 10})
film5 = Film.new( { 'title' => 'Citizen Kane', 'price' => 10})



customer1.save()
customer2.save()
customer3.save()
customer4.save()
customer5.save()
customer6.save()

film1.save()
film2.save()
film3.save()
film4.save()
film5.save()

ticket1 = Ticket.new( {'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()
