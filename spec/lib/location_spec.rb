require 'location'

describe Location do

  describe "comparing locations" do
    context "when locations have the same values for row and column" do
      it "returns true" do
        location = Location.new(1, 1)
        equivalent_location = Location.new(1, 1)
        expect(location).to eq(equivalent_location)
      end
    end
  end

  describe "using a location as a hash key" do
    it "can be used as a hash key" do
      a_hash = {}
      location = Location.new(0, 0)
      equivalent_location = Location.new(0, 0)

      a_hash[location] = :a_value

      expect(a_hash[equivalent_location]).to eq(:a_value)
    end
  end

  describe "#shift" do
    it "returns a new location shifted by offsets" do
      location = Location.new(1, -1)
      shifted_location = location.shift(1, 1)

      expect(shifted_location).to eq(Location.new(2, 0))
    end
  end
end
