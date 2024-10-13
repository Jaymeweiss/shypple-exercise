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
end
