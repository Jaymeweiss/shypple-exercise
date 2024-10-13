require "test_helper"

class RouteTest < ActiveSupport::TestCase
  fixtures :shipping_options, :exchange_rates, :rates

  test "should determine the correct duration of a route with multiple stops" do
    route = Route.new([
      shipping_options(:cnsha_nlrtm_2022_01_29),
      shipping_options(:esbcn_nlrtm_2022_02_16)
    ])

    assert_equal 22, route.duration
  end

  test "should determine the correct duration of a route with a single stop" do
    route = Route.new([
                        shipping_options(:cnsha_nlrtm_2022_01_29),
                      ])

    assert_equal 17, route.duration
  end

  test "should determine the correct price of a given route with EUR and non-EUR values" do
    route = Route.new([
      shipping_options(:cnsha_nlrtm_2022_01_29),
      shipping_options(:esbcn_nlrtm_2022_02_16)
    ])

    assert_in_delta 822.89, route.price_in_euro, 0.01
  end

  test "should determine the correct price of a given route with only EUR values" do
    route = Route.new([
                        shipping_options(:cnsha_esbcn_2022_01_29),
                        shipping_options(:cnsha_nlrtm_2022_01_29)
                      ])

    assert_in_delta 1023.92, route.price_in_euro, 0.01
  end

  test "should determine the correct price of a given route with only non-EUR values" do
    route = Route.new([
                        shipping_options(:cnsha_nlrtm_2022_01_31),
                        shipping_options(:cnsha_nlrtm_2022_01_30)
                      ])

    assert_in_delta 1152.89, route.price_in_euro, 0.01
  end
end
