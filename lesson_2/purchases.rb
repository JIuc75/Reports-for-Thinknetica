basket = {}
loop do
  puts 'Введите название товара'
  title = gets.chomp
  break if title == 'стоп'
  puts 'Введите цену за еденицу товара'
  price = gets.to_f
  puts 'Введите количество товара'
  quantity = gets.to_i
  basket[title] = { price: price, amount: quantity }
end
puts "Товары в корзине: #{basket}"
total = 0
basket.each do |product, quan|
  item_sum = quan[:price] * quan[:amount]
  total += item_sum
  puts "Общая стоимость по товару #{product} составляет - #{item_sum}"
end

puts "Общая стоимость по корзине составляет - #{total}"
