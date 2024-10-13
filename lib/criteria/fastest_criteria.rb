module Criteria
  class FastestCriteria < Criteria
    def matching_routes
      sorted_routes = all_possible_routes.sort_by(&:duration)
      return [] if sorted_routes.empty?
      fastest_duration = sorted_routes.first.duration
      sorted_routes.select { |route| route.duration == fastest_duration }
    end
  end
end
