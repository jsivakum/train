require('spec_helper')

describe (Station) do

  describe(".all") do
    it ("returns with no stations") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns station name") do
      station = Station.new({:name => "Gingerbread House", :id => nil})
      expect(station.name()).to(eq("GINGERBREAD HOUSE"))
    end
  end

  describe("#id") do
    it("returns id") do
      station = Station.new({:name => "Gingerbread House", :id => nil})
      station.save()
      expect(station.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("returns true if name and id are the same") do
      station1 = Station.new({:name => "Gingerbread House", :id => nil})
      station2 = Station.new({:name => "Gingerbread House", :id => nil})
      expect(station1).to(eq(station2))
    end
  end

  describe("#find") do
    it("returns a station by its id number") do
      test_station = Station.new({:name => "Cherrybomb Station", :id => nil})
      test_station.save()
      test_station2 = Station.new({:name => "Gingerbread House", :id => nil})
      test_station2.save()
      expect(Station.find(test_station.id())).to(eq(test_station))
    end
  end


  describe("#lines_at_station") do
    it("returns array of lines that stop at that station") do
        test_line = Line.new({:name => "Gundrop Lane", :id => nil})
        test_line.save()
        test_line2 = Line.new({:name => "Gumdrop Lane", :id => nil})
        test_line2.save()
        test_station = Station.new({:name => "Cherrybomb Station", :id => nil})
        test_station.save()
        test_station2 = Station.new({:name => "Gingerbread House", :id => nil})
        test_station2.save()
        test_line.create_association_stations_to_line(test_station)
        test_line2.create_association_stations_to_line(test_station)
        expect(Station.lines_at_station(test_station)).to(eq([test_line, test_line2]))
    end
  end

end
