module Twirloc
  class MidpointCalculator
    def self.calculate(coordinates)
			x = 0
      y = 0
      z = 0

      coordinates.each do |coord|
        # Convert latitude and longitude from degrees to radians
        lat = self.to_radian(coord[0])
        lon = self.to_radian(coord[1])

        # Convert lat/lon to Cartesian coordinates for first location
        a = Math.cos(lat) * Math.cos(lon)
        b = Math.cos(lat) * Math.sin(lon)
        c = Math.sin(lat)

        x += a
        y += b
        z += c
      end

      # Compute average x, y and z coordinates.
      x /= coordinates.count
      y /= coordinates.count
      z /= coordinates.count

      # Convert average x, y, z coordinate to latitude and longitude
      lon = Math.atan2(y, x)
      hyp = Math.sqrt(x * x + y * y)
      lat = Math.atan2(z, hyp)

      # Convert lat and lon to degrees
      [(lat * 180 / Math::PI), (lon * 180 / Math::PI)]
    end

		def self.distance_between(point1, point2)
			# in km
      earth_radius = 6371.0   # km

      # convert degrees to radians
      point1 = point1.map { |c| to_radian(c) }
      point2 = point2.map { |c| to_radian(c) }

      # compute deltas
      dlat = point2[0] - point1[0]
      dlon = point2[1] - point1[1]

      a = (Math.sin(dlat / 2))**2 + Math.cos(point1[0]) *
          (Math.sin(dlon / 2))**2 * Math.cos(point2[0])
      c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
      c * earth_radius
    end

    def self.to_radian(coord)
      coord * Math::PI / 180
    end
  end
end
