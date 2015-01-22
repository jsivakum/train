require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/line")
require("./lib/station")
require("pg")

DB = PG.connect({:dbname => "train_system"})

get("/") do
  @lines = Line.all()
  @stations = Station.all()
  erb(:conductor)
end

post("/lines") do
  name = params["name"]
  line = Line.new({:name => name})
  line_id = line.id()
  line.save()
  @line = Line.find(line_id)
  erb(:index)
end

post("/stations") do
  name = params["name"]
  station = Station.new({:name => name})
  station_id = station.id()
  line.save()
  @station = Station.find(station_id)
  erb(:index)
end

get("/lines/:id") do
  @list = Line.find(params["id"].to_i())
  erb(:lines)
end
