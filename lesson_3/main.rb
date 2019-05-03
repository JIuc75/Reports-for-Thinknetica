require './station.rb'
require './route.rb'
require './train.rb'

puts 'Вас приветствует программа управления поездами'
puts 'Введите номер поезда'
number_train = gets.chomp
puts 'Введите тип поезда'
train_type = gets.chomp
puts 'Введите количество вагонов'
train_amount_wagons = gets.to_i
train = Train.new(number_train, train_type, train_amount_wagons)

puts train.type
puts train.number
puts train.amount_of_wagons

puts 'Укажите начальную станцию'
start_station = gets.chomp
puts 'Укажите конечную станцию'
end_station = gets.chomp
route = Route.new(Station.new(start_station), Station.new(end_station))
puts route.start_station.name
puts route.end_station.name
puts 'Добавте промежуточные станции'
loop do
  station = gets.chomp
  route.add_station(station)
  break if station == 'stop'
end
train.route = route
loop do
  puts 'Для оправки поезда введите start'
  start = gets.chomp
  train.forward if start == 'start'
  puts train.current_station.name
  break if start == 'stop'
end

