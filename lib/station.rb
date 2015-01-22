class Station
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @name = @name.upcase()
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_stations.each() do |station|
      name = station["name"]
      id = station["id"].to_i()
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  define_method(:==) do |another_station|
    self.name() == another_station.name() && self.id() == another_station.id()
  end

  define_singleton_method(:find) do |id|
    Station.all().each do |station|
      if(station.id() == id)
        @found_station = station
      end
    end
    @found_station
  end

  define_singleton_method(:lines_at_station) do |station|
    line_ids = []
    returned_lines = []

    returned_rows = DB.exec("SELECT * FROM stops WHERE station_id = #{station.id()};")
    returned_rows.each() do |row|
      line_id = row["line_id"].to_i()
      line_ids.push(line_id)
    end

    lines_all = Line.all()
    lines_all.each() do |line|
      if line_ids.include?(line.id())
        returned_lines.push(line)
      end
    end

    returned_lines
  end

end
