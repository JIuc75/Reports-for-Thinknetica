new_array = []
101.times do |item|
  new_array << item if (item % 5).zero?
end
puts new_array
