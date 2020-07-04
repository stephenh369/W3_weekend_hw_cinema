require_relative('../db/sql_runner')

class Screening

    attr_reader :id
    attr_accessor :time, :tickets_left, :film_id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @time = options['time']
        @tickets_left = options['tickets_left'].to_i
        @film_id = options['film_id'].to_i
    end

    def save()
        sql = "INSERT INTO screenings (time, tickets_left, film_id) VALUES ($1, $2, $3) RETURNING id"
        values = [@time, @tickets_left, @film_id]
        screening = SqlRunner.run(sql, values).first
        @id = screening['id'].to_i
    end

    def update()
        sql = "UPDATE screenings SET (time, tickets_left, film_id) = ($1, $2, $3) WHERE id = $4"
        values = [@time, @tickets_left, @film_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM screenings WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end
end