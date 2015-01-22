class Line
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @name = @name.upcase()
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line["name"]
      id = line["id"].to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  define_method(:==) do |another_line|
    self.name() == another_line.name() && self.id() == another_line.id()
  end

  define_singleton_method(:find) do |id|
    Line.all().each do |line|
      if(line.id() == id)
        @found_line = line
      end
    end
    @found_line
  end

  define_method(:create_association_stations_to_line) do |station|
    DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{self.id()}, #{station.id()});")
  end

  define_singleton_method(:stations_on_line) do |line|
    station_ids = []
    returned_stations = []

    returned_rows = DB.exec("SELECT * FROM stops WHERE line_id = #{line.id()};")
    returned_rows.each() do |row|
      station_id = row["station_id"].to_i()
      station_ids.push(station_id)
    end

    stations_all = Station.all()
    stations_all.each() do |station|
      if station_ids.include?(station.id())
        returned_stations.push(station)
      end
    end

    returned_stations
  end

end
