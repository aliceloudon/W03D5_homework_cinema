require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i    
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING id"
    customer = SqlRunner.run(sql).first
    @id = customer['id'].to_i
  end

  def update
    sql ="UPDATE customers set (name, funds) = ('#{@name}', #{@funds}) WHERE id =#{@id};"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return self.get_many(sql)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map {|customer| Customer.new(customer)}
    return result
  end

  def films
    sql = "SELECT films.* FROM films
          INNER JOIN tickets ON film_id = films.id
          WHERE customer_id = #{@id}"
    return Film.get_many(sql)
  end

  def tickets
    sql = "SELECT * FROM tickets WHERE customer_id = #{@id}"
    result = SqlRunner.run(sql)
    return result.map {|ticket| Ticket.new(ticket)}
  end

  def buy_ticket(customer, film)
    funds = (customer.funds - film.price)
    update
  end

    # def update
    #   sql ="UPDATE customers set (name, funds) = ('#{@name}', #{@funds}) WHERE id =#{@id};"
    #   SqlRunner.run(sql)
    # end

# when I enter ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
# I want to automatically:
# customer1.funds = (customer1.funds - film1.price)
# customer1.update
# So the two arguments I want to enter are CUSTOMER and FILM


end
