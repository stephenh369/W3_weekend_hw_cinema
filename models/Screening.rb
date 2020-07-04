require_relative('../db/sql_runner')

class Screening

    attr_reader :id
    attr_accessor :time, :tickets_sold, :tickets_left, :film_id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @time = options['time']
        @tickets_sold = options['tickets_sold'].to_i
        @tickets_left = options['tickets_left'].to_i
        @film_id = options['film_id'].to_i
    end

    def save()
        sql = "INSERT INTO screenings (time, tickets_sold, tickets_left, film_id) VALUES ($1, $2, $3, $4) RETURNING id"
        values = [@time, @tickets_sold, @tickets_left, @film_id]
        screening = SqlRunner.run(sql, values).first
        @id = screening['id'].to_i
    end

    def update()
        sql = "UPDATE screenings SET (time, tickets_sold, tickets_left, film_id) = ($1, $2, $3, $4) WHERE id = $5"
        values = [@time, @tickets_sold, @tickets_left, @film_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM screenings WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def film()
        sql = "SELECT * FROM films WHERE id = $1"
        values = [@film_id]
        film = SqlRunner.run(sql, values).first
        return Film.new(film)
    end

    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end

    def self.all()
        sql = "SELECT * FROM screenings"
        all_screenings = SqlRunner.run(sql)
        result = all_screenings.map() {|screening| Screening.new(screening)}
        return result
    end
end