require_relative('../db/sql_runner')

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @funds = options['funds'].to_i
    end

    def save()
        sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values).first
        @id = customer['id'].to_i
    end

    def update()
        sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM customers WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def films()
        sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
        values = [@id]
        film_list = SqlRunner.run(sql, values)
        result = film_list.map() {|film| Film.new(film)}
    end

    def tickets()
        sql = "SELECT tickets.* FROM tickets WHERE customer_id = $1"
        values = [@id]
        ticket_info = SqlRunner.run(sql, values)
        return ticket_info.map() {|ticket| Ticket.new(ticket)}
    end
    
    def ticket_count()
        return self.tickets.count
    end

    def create_ticket(film_id, screening_id)
        ticket = Ticket.new({'customer_id' => self.id, 'film_id' => film_id, 'screening_id' => screening_id})
        ticket.save()
        return ticket
    end

    def buy_ticket(film_id, screening_id)
        create_ticket(film_id, screening_id)
        sql = "SELECT * FROM films WHERE id = $1"
        values = [film_id]
        film_info = SqlRunner.run(sql, values).first
        if self.funds > film_info['price'].to_i
            self.funds -= film_info['price'].to_i
            self.update()
        else
            return "Insufficient funds."
        end
    end

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end

    def self.all()
        sql = "SELECT * FROM customers"
        all_customers = SqlRunner.run(sql)
        result = all_customers.map() {|customer| Customer.new(customer)}
        return result
    end



end