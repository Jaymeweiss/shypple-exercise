require "test_helper"

class CriteriaTest < ActiveSupport::TestCase
  fixtures :shipping_options, :exchange_rates, :rates

  test "should determine that there are no correct routes if there aren't any" do
    criteria = Criteria::Criteria.new("NLRTM", "BRSSZ")
    routes = criteria.send(:all_possible_routes)
    assert_equal 0, routes.count
  end

  test "should determine the correct routes for a given origin and destination port" do
    criteria = Criteria::Criteria.new("CNSHA", "NLRTM")
    routes = criteria.send(:all_possible_routes)
    assert_equal 7, routes.count
    assert_equal [
                   ["ABCD"],
                   ["EFGH"],
                   ["ERXQ", "ETRF"],
                   ["ERXQ", "ETRG"],
                   ["IJKL"],
                   ["MNOP"],
                   ["QRST"]
                 ], routes.each_with_object([]) { |route, arr| arr << route.stops.map { |stop| stop.sailing_code }.sort }.sort
  end

  test "should determine the correct routes even when there are indirect options" do
    criteria = Criteria::Criteria.new("CNSHA", "BRSSZ")
    routes = criteria.send(:all_possible_routes)
    assert_equal 1, routes.count
    assert_equal ["ERXQ","ETRB"], routes[0].stops.map { |stop| stop.sailing_code }.sort
    assert_equal 2, routes[0].stops.count
  end

end