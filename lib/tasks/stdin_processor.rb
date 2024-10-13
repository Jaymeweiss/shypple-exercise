loop do
  input_hash = {}
  line_index = 0
  should_close = false
  puts "Please enter the shipping details in the following format: "
  puts "Line 1: The origin_port code"
  puts "Line 2: The destination_port code"
  puts "Line 3: The criteria (cheapest-direct, cheapest, fastest)"
  puts "Type 'exit' to close the program"

  loop do
    input = $stdin.gets
    break if input.nil? || input.strip.empty?
    input_text = input.strip
    if input_text == "exit"
      should_close = true
      break
    end
    line_index += 1
    case line_index
    when 1
      input_hash[:origin_port] = input_text
    when 2
      input_hash[:destination_port] = input_text
    when 3
      input_hash[:criteria] = input_text
      break
    else
      break
    end
  end

  should_close && break

  klass = case input_hash[:criteria]
          when "cheapest-direct"
            Criteria::CheapestDirectCriteria
          when "cheapest"
            Criteria::CheapestCriteria
          when "fastest"
            Criteria::FastestCriteria
          else
            nil
          end
  routes = klass&.new(input_hash[:origin_port], input_hash[:destination_port])&.matching_routes || []

  puts "The #{input_hash[:criteria]} route between #{input_hash[:origin_port]} and #{input_hash[:destination_port]}: "
  puts "No routes found" if routes.empty?
  routes_json = routes.map do |route|
    route.printable_route
  end.to_json
  puts routes_json
  puts "-----------------------------------"
end
