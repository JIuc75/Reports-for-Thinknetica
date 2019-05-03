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

puts 'Укажите начальную станцию'
start_station = gets.chomp
puts 'Укажите конечную станцию'
end_station = gets.chomp
route = Route.new(Station.new(start_station), Station.new(end_station))

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
  break if start == 'stop'
  puts "Поезд прибыл на станцию #{train.current_station.name}"
end

loop do
  puts 'Для возврата поезда введите back'
  back = gets.chomp
  train.backward if back == 'back'
  break if back == 'stop'
  puts "Поезд прибыл на станцию #{train.current_station.name}"
end
