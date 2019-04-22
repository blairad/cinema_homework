require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./tickets')

require('pry')

class Film

  attr_accessor :price, :title
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
      (
        title,
        price
      ) VALUES
      (
        $1, $2
      ) RETURNING id"
    values = [@title, @price]
    films = SqlRunner.run(sql, values)
    @id = films[0]['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customer_film_choice()
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          INNER JOIN films
          ON films.id = tickets.film_id
          WHERE films.id = $1 "
    values = [@id]
    x = SqlRunner.run(sql, values)
    p x.map{|each_customer| Customer.new(each_customer)}
  end

  # extension. i want all the customer who go to certain film
  def films_watched()
    sql = "SELECT * FROM tickets WHERE film_id = $1"
    values = [@id]
    films_watched = SqlRunner.run(sql, values)
    p films_watched.count{ |watched| Film.new(watched)}

     # binding.pry
     # nil
  end
  #extension

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    all_films = SqlRunner.run(sql)
    return self.map_items(all_films)
  end

  def self.map_items(film_data)
    results = film_data.map { |film| Film.new(film)}
    p results
  end

end


# Basic extensions:
# Buying tickets should decrease the funds of the customer by the price
# Check how many tickets were bought by a customer
# Check how many customers are going to watch a certain film
# Advanced extensions:
# Create a screenings table that lets us know what time films are showing
# Write a method that finds out what is the most popular time (most tickets sold) for a given film
# Limit the available tickets for screenings.
# Add any other extensions you think would be great to have at a cinema!
