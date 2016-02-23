module Twirloc
  module Algorithms
    module KMeans
      class Clusterer
        MAX_FIXNUM =  (2**(0.size * 8 - 2) - 1)
        MAX_ITERATIONS = 100

        attr_reader :data_points
        attr_accessor :clusters

        def initialize(options)
          raise ArgumentError,  "Please initialize with data points" if options[:data_points].nil?
          options = defaults.merge(options)
          @num_clusters = options[:num_clusters]
          @data_points = convert_data_points(options[:data_points])
          @clusters = options[:clusters]
        end

        def run
          compute_initial_centroids if clusters.empty?
          MAX_ITERATIONS.times do
            clear_clusters
            assign_points_to_nearest_cluster
            old_clusters = Marshal.load(Marshal.dump(clusters))
            recompute_centroids
            assign_points_to_nearest_cluster
            clusters_did_not_change = old_clusters.zip(clusters).collect {|c1, c2| c1 == c2 }
            break unless clusters_did_not_change.include?(false)
          end
        end

        def to_chart_data
          chart_data = []
          clusters.each_with_index do |cluster, index|
            chart_data += cluster.data_points.map { |dp| [dp.latitude, dp.longitude, index + 1] }
          end
          chart_data
        end

        private

        def assign_points_to_nearest_cluster
          data_points.each do |data_point|
            min_distance, nearest_cluster  = MAX_FIXNUM, nil
            clusters.each do |cluster|
              distance = data_point.geographic_distance(cluster.centroid.to_coordinates)
              if distance < min_distance
                nearest_cluster = cluster
                min_distance = distance
              end
            end
            nearest_cluster.add_datapoint(data_point)
          end
        end

        def recompute_centroids
          clusters.each { |cluster| cluster.recompute_centroid! }
        end

        def clear_clusters
          clusters.each { |cluster| cluster.clear! }
        end

        def compute_initial_centroids
          @num_clusters.times do
            centroid = data_points.sample
            clusters << Cluster.new(centroid: centroid)
          end
        end

        def convert_data_points(points)
          points.collect do |point|
            Twirloc::Algorithms::KMeans::DataPoint.new(latitude: point[0], longitude: point[1])
          end
        end

        def defaults
          { clusters: [], data_points: [], num_clusters: 3 }
        end
      end
    end
  end
end
