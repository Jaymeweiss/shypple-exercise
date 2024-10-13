module Criteria
  class CheapestCriteria < Criteria
    def matching_routes
      sorted_routes = all_possible_routes.sort_by(&:price_in_euro)
      return [] if sorted_routes.empty?
      cheapest_price = sorted_routes.first.price_in_euro
      sorted_routes.select { |route| route.price_in_euro == cheapest_price }
    end
  end
end