Dotenv.load

module Twirloc
  class GoogleLocation
    attr_reader :api_key, :coords, :conn

    def initialize(opts)
      @api_key = opts[:api_key] || ENV["GOOGLE_GEO_KEY"]
      @coords = stringify(opts[:coords])
    end

    def to_s
      results = response["results"]
      formatted_addresses = results.collect { |r| r["formatted_address"] }
      addresses = formatted_addresses.select { |a| a.split(",").count == 3 }
      addresses.first
    end

    def host
      "https://maps.googleapis.com/"
    end

    def params
      "maps/api/geocode/json?latlng=#{coords}&key=#{api_key}"
    end

    def make_request
      conn.get params
    end

    def response
      JSON.parse(make_request.body)
    end

    def stringify(coordinates)
      coordinates.join(",")
    end

    def conn
			@_conn = Faraday.new(:url => host) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
