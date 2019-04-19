require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./tickets')

require('pry')


class Ticket

  attr_reader :id, :customer_id, :film_id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    ) VALUES
    (
      $1, $2
    ) RETURNING id"
    values = [@customer_id, @film_id]
    tickets = SqlRunner.run(sql, values)
    @id = tickets[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    all_tickets = SqlRunner.run(sql)
    #all_tickets.map{|tickets| Ticket.new(tickets)}
    return self.map_items(all_tickets)
     # p results
  end

  def self.map_items(ticket_data)
    results = ticket_data.map { |ticket| Ticket.new(ticket) }
    p results
  end

end
