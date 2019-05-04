require_relative 'station'
require_relative 'route'
require_relative 'train'

@stations = []

def create_station
  loop do
    puts 'Введите название станции или просто нажмите Enter, чтобы выйти'
    name = gets.chomp
    break if name == ''
    @stations << Station.new(name)
    @stations.each.with_index(1) { |station, index| puts "Cтанция #{index} - #{station.name}" }
  end
end

@trains = []

def create_trains
  loop do
    puts 'Введите № поезда и тип или просто нажмите Enter, чтобы выйти'
    number = gets.chomp
    type = gets.chomp
    break if number == ''
    @trains << Train.new(number, type)
    @trains.each.with_index(1) { |train, index| puts "Поезд #{index} № #{train.number} - #{train.type}" }
  end
end

@routes = []

def create_routes
  loop do
    puts 'Введите номер маршрута или пустую строку (просто нажмите Enter), чтобы выйти'
    number_route = gets.chomp
    puts 'Введите название первой станции'
    one_station = gets.chomp
    puts 'Введите название последней станции'
    end_station = gets.chomp
    break if number_route == ''
    @routes << Route.new(@stations.find { |st| st.name == one_station }, @stations.find { |st| st.name == end_station })
    @routes.each.with_index(1) do |route, index|
      puts "Маршрут #{index} - первая станция #{route.stations[0].name}, последняя станция #{route.stations[-1].name}"
    end
  end
end
create_station
create_trains
create_routes