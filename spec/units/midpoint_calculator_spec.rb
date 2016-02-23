require 'spec_helper'

RSpec.describe Twirloc::MidpointCalculator do
  describe ".calculate" do
    it "is the midpoint between a collection of latitude, longitude coordinates" do
      coords = [
                [39.33090026, -76.6426334],
                [40.72412842, -73.9972651],
                [37.61865062, -122.38100052]
               ]
      midpoint = described_class.calculate(coords)
      expect(midpoint).to eq([41.41308305998285, -90.9746275062176])
    end
  end
end
