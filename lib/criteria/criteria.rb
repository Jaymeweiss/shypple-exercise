module Criteria
  class Criteria
    def initialize(origin_port, destination_port)
      @origin_port = origin_port
      @destination_port = destination_port
    end

    def matching_routes
      raise NotImplementedError "This method should be implemented in a specific criteria class"
    end

    private

    def all_possible_routes
      # find all the possible starting points to search for routes from
      origin_options = ShippingOption.where(origin_port: @origin_port)
      all_routes = []
      origin_options.each do |option|
        determine_route(option, @destination_port, [], all_routes)
      end
      all_routes
    end

    def determine_route(shipping_option, destination_port, route_array, all_routes_array)
      # when an option is at the destination - complete the route array and add it to the full list of routes
      if shipping_option.destination_port == destination_port
        route_array << shipping_option
        all_routes_array << Route.new(route_array)
        # we have recorded our route - end this lookup
        return
      end
      # check if we have other options that we need to be checking
      other_options = ShippingOption.where("origin_port = ? AND departure_date >= ?", shipping_option.destination_port, shipping_option.arrival_date)

      # Add the current shipping option to the route array if there are other options for us to be checking
      route_array << shipping_option if other_options

      # if we do have other options, we should keep building the route, to see if there are any others that might reach the destination
      other_options.each do |other_option|
        determine_route(other_option, destination_port, route_array.dup, all_routes_array)
      end
    end
  end
end
