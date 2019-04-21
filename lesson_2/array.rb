new_array = []
range = (1..100)
range.each do |item|
  new_array << item if (item % 5).zero?
end
puts new_array
