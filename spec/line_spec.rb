require('spec_helper')

describe (Line) do

  describe(".all") do
    it ("returns with no lines") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns line name") do
      line = Line.new({:name => "Gumdrop Lane", :id => nil})
      expect(line.name()).to(eq("GUMDROP LANE"))
    end
  end

  describe("#id") do
    it("returns id") do
      line = Line.new({:name => "Gumdrop Lane", :id => nil})
      line.save()
      expect(line.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("returns true if name and id are the same") do
      line1 = Line.new({:name => "Gumdrop Lane", :id => nil})
      line2 = Line.new({:name => "Gumdrop Lane", :id => nil})
      expect(line1).to(eq(line2))
    end
  end

  describe("#find") do
    it("returns a line by its id number") do
      test_line = Line.new({:name => "Gundrop Lane", :id => nil})
      test_line.save()
      test_line2 = Line.new({:name => "Gumdrop Lane", :id => nil})
      test_line2.save()
      expect(Line.find(test_line.id())).to(eq(test_line))
    end
  end

  describe("#stations_on_line") do
    it("returns array of stations on a specified line") do
        test_line = Line.new({:name => "Gundrop Lane", :id => nil})
        test_line.save()
        test_line2 = Line.new({:name => "Gumdrop Lane", :id => nil})
        test_line2.save()
        test_station = Station.new({:name => "Cherrybomb Station", :id => nil})
        test_station.save()
        test_station2 = Station.new({:name => "Gingerbread House", :id => nil})
        test_station2.save()
        test_line.create_association_stations_to_line(test_station)
        test_line.create_association_stations_to_line(test_station2)
        expect(Line.stations_on_line(test_line)).to(eq([test_station, test_station2]))
    end
  end
end
