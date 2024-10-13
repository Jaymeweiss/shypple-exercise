module Criteria
  class CheapestDirectCriteria < Criteria
    def matching_routes
      sorted_routes = all_possible_routes.sort_by(&:price_in_euro)
      return [] if sorted_routes.empty?
      cheapest_price = sorted_routes.first.price_in_euro
      sorted_routes.select { |route| route.price_in_euro == cheapest_price }
    end

    private

    def all_possible_routes
      # find all the possible starting points to search for routes from
      origin_options = ShippingOption.where(origin_port: @origin_port, destination_port: @destination_port)
      origin_options.map { |option| Route.new([option]) }
    end
  end
end