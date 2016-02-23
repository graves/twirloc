module Twirloc
  module Algorithms
    module KMeans
      class Cluster
        attr_reader :data_points, :centroid

        def initialize(options)
          options = defaults.merge(options)
          @data_points = Set.new(options[:data_points])
          @centroid = options[:centroid]
        end

        def recompute_centroid!
          coords = data_points.collect { |p| p.to_coordinates }
          lat, lng = MidpointCalculator.calculate(coords)
          @centroid = DataPoint.new(latitude: lat, longitude: lng)
        end

        def add_datapoint(data_point)
          data_points.add(data_point)
        end

        def clear!
          data_points.clear
        end

        def ==(other_object)
          @data_points == other_object.data_points
        end

        private

        def defaults
          { data_points: Set.new }
        end
      end
    end
  end
end
