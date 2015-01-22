class Stop
  attr_reader(:id, :station_id, :line_id)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @station_id = attributes[:station_id]
    @line_id = attributes[:line_id]
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      id = stop['id'].to_i()
      station_id = stop['station_id'].to_i()
      line_id = stop['line_id'].to_i()
      stops.push(Stop.new({:id => nil, :station_id => station_id, :line_id => line_id}))
    end
    stops
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{@station_id}, #{@line_id}) RETURNING id;")
    @id = result.first()['id'].to_i()
  end

end
