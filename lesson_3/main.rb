require_relative 'station'
require_relative 'route'
require_relative 'train'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def create_stations
    loop do
      puts 'Введите название станции или просто нажмите Enter, чтобы выйти'
      name = gets.chomp
      break if name == ''

      @stations << Station.new(name)
      @stations.each.with_index(1) do |station, index|
        puts "Cтанция #{index} - #{station.name}"
      end
    end
  end

  def create_trains
    loop do
      puts 'Введите № поезда и тип или просто нажмите Enter, чтобы выйти'
      number = gets.to_i
      break if number == 0

      type = gets.chomp
      @trains << Train.new(number, type)
      @trains.each.with_index(1) do |train, index|
        puts "Поезд #{index} № #{train.number} - #{train.type}"
      end
    end
  end

  def create_routes
    loop do
      puts 'Введите номер маршрута или пустую строку (просто нажмите Enter), чтобы выйти'
      number_route = gets.to_i
      break if number_route == 0

      puts 'Введите название первой станции'
      one_station = gets.chomp
      puts 'Введите название последней станции'
      end_station = gets.chomp
      @routes << Route.new(@stations.find { |st| st.name == one_station },
                           @stations.find { |st| st.name == end_station },
                           number_route)
      @routes.each.with_index(1) do |route, index|
        puts "Маршрут #{index} - первая станция #{route.stations[0].name}, последняя станция #{route.stations[-1].name}"
      end
    end
  end

  def add_stations
    puts 'Введите название станции'
    name_station = gets.chomp
    puts 'Введите номер маршрута'
    number_route = gets.to_i
    @routes.each do |route|
      if route.number_route == number_route
        route.add_station(@stations.find { |st| st.name == name_station })
      end
    end
  end

  def set_rote_for_train
    puts 'Введите номер маршрута'
    number_route = gets.to_i
    puts 'Введите номер поезда'
    number_train = gets.to_i
    @trains.each do |train|
      if train.number == number_train
        train.route = (@routes.find { |route|
          route.number_route == number_route })
      end
      @trains.each { |train| puts "Поезду присвоен маршрут #{train.route.number_route}" if train.number == number_train }
    end
  end
end

mn = Main.new
mn.create_stations
mn.create_trains
mn.create_routes

mn.set_rote_for_train

