require_relative('../db/sql_runner')
require_relative('./films')

class Customer

  attr_reader :id, :name
  attr_accessor :funds

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

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
