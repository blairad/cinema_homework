require_relative('../db/sql_runner')
require_relative('./films')
require_relative('./tickets')
# require_relative('./customer')


require('pry')


class Customer

  attr_reader :id
  attr_accessor :funds, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
        (
          name,
          funds
        ) VALUES
        (
          $1, $2
        ) RETURNING id"
    values = [@name, @funds]
    customers = SqlRunner.run(sql, values)
    @id = customers[0]['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def tickets_bought()
    sql = "SELECT films.* FROM films
          INNER JOIN tickets
          ON films.id = tickets.film_id
          INNER JOIN customers
          ON customers.id = tickets.customer_id
          WHERE customers.id = $1 "
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    return Film.map_items(ticket_data)
  end

  #extension

  def number_of_tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    customer_ticket_data = SqlRunner.run(sql, values)
    p customer_ticket_data.count{ |cust| Customer.new(cust)}
  end

  def buying_tickets
    ticket_cost = se 
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    all_customers = SqlRunner.run(sql)
    return self.map_items(all_customers)
  end

  def self.map_items(customer_data)
    results = customer_data.map { |customer| Customer.new(customer) }
    #p results
  end

end
