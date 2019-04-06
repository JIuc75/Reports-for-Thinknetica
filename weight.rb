puts 'Здравствуйте, как вас зовут?'
name = gets.chomp.capitalize
puts 'Введите рост'
growth = gets.to_i
ideal_weight = growth - 110
if ideal_weight < 0
  puts "Привет #{name}, твой вес оптимальный"
else
  puts "Привет #{name}, твой оптимальный вес #{ideal_weight}"
end
