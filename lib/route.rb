class Route

  attr_reader :stops

  def initialize(stops = [])
    @stops = stops
  end

  def price_in_euro
    @price_in_euro ||= begin
                         stops.reduce(0.0) do |sum, stop|
                           rate = Rate.find_by(sailing_code: stop.sailing_code)
                           # The exchange rates are in EURO so we only convert the price if the rate is not in EURO
                           if rate.rate_currency != "EUR"
                             exchange_rate = ExchangeRate.find_by(currency: rate.rate_currency, date: stop.departure_date)
                             sum + (rate.rate / exchange_rate.rate)
                           else
                             sum + rate.rate
                           end
                         end
                       end
  end

  def duration
    # Using the assumption that we are working with whole dates and not DateTime. We can use DateTime here as well - we will just be comparing seconds to seconds instead
    @duration ||= stops.last.arrival_date - @stops.first.departure_date
  end

  def printable_route
    stops.map { |stop| stop_hash(stop) }
  end

  private

  def stop_hash(stop)
    rate = Rate.find_by(sailing_code: stop.sailing_code)
    {
      "origin_port": stop.origin_port,
      "destination_port": stop.destination_port,
      "departure_date": stop.departure_date.strftime("%Y-%m-%d"),
      "arrival_date": stop.arrival_date.strftime("%Y-%m-%d"),
      "sailing_code": stop.sailing_code,
      "rate": rate.rate,
      "rate_currency": rate.rate_currency
    }
  end
end
