require('spec_helper')

describe (Stop) do

  describe(".all") do
    it ("returns with no stops") do
      expect(Stop.all()).to(eq([]))
    end
  end


  describe("#id") do
    it("returns id") do
      stop = Stop.new({:station_id => 1, :line_id => 1})
      stop.save()
      expect(stop.id()).to(be_an_instance_of(Fixnum))
    end
  end

end
