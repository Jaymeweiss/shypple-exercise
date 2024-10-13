require "test_helper"

class CheapestCriteriaTest < ActiveSupport::TestCase
  fixtures :shipping_options, :exchange_rates, :rates

  test "should return the cheapest route if there is only 1 with the matching criteria" do
    criteria = Criteria::CheapestCriteria.new("CNSHA", "NLRTM")
    routes = criteria.matching_routes
    assert_equal 1, routes.size
    assert_equal ["ERXQ", "ETRG"], routes[0].stops.map { |stop| stop.sailing_code }.sort
    assert_equal 2, routes[0].stops.count
  end

  test "should return nothing if there no possible routes" do
    criteria = Criteria::CheapestCriteria.new("NLRTM", "BRSSZ")
    routes = criteria.matching_routes
    assert_equal 0, routes.count
  end
end
