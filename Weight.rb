puts 'Здравствуйте, как вас зовут?'
name = gets.to_s
puts 'Введите рост'
growth = gets.to_i
if growth <= 1
  puts "Привет #{name}, твой оптимальный вес #{growth - 110}"
else
  puts "Привет #{name}, твой вес оптимальный"
end