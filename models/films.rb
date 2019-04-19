require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./tickets')

class Film

  attr_accessor :price
  attr_reader :id, :title

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
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

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
