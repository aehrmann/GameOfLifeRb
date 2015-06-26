require 'location'

describe Location do
  describe 'comparing locations' do
    it 'is equal to another location if its row and column are both equal' do
      location_one = Location.new(0, 0)
      location_two = Location.new(0, 0)
      expect(location_one).to eq(location_two)
    end
  end

  describe 'displaying locations' do
    it 'prints its row and column' do
      location = Location.new(3, 3)
      expected_string = 'Location(3, 3)'
      expect(location.to_s).to eq(expected_string)
    end
  end
end
