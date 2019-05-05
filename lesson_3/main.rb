require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagons'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'

class Main
  attr_reader :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def stations_exist?(name_station)
    @stations.find { |station| station.name == name_station }
  end

  def trains_exist?(number_train)
    @trains.find { |train| train.number == number_train }
  end

  def routes_exist?(number_route)
    @routes.find { |route| route.number_route == number_route }
  end

  def wagons_exist?(number_wagons)
    @routes.find { |route| route.number_route == number_wagons }
  end

  def create_stations
    loop do
      puts 'Введите название станции или просто нажмите Enter, чтобы выйти'
      name_station = gets.chomp
      break if name_station == ''

      if stations_exist?(name_station)
        puts 'Станция с таким названием уже существует!'
      else
        @stations << Station.new(name_station)
      end
      @stations.each.with_index(1) do |station, index|
        puts "Cтанция #{index} - #{station.name}"
      end
    end
  end

  def create_trains
    loop do
      puts 'Введите № поезда и тип или просто нажмите Enter, чтобы выйти'
      number_train = gets.to_i
      break if number_train.zero?

      type = gets.chomp
      if number_train.zero? || trains_exist?(number_train)
        puts 'Поезд таким номером уже существует!'
      else
        @trains << Train.new(number_train, type)
      end
      @trains.each.with_index(1) do |train, index|
        puts "Поезд #{index} № #{train.number} - #{train.type}"
      end
    end
  end

  def create_routes
    loop do
      puts 'Введите номер маршрута или пустую строку (просто нажмите Enter), чтобы выйти'
      number_route = gets.to_i
      break if number_route.zero?

      puts 'Введите название первой станции'
      one_station = gets.chomp
      puts 'Введите название последней станции'
      end_station = gets.chomp
      if number_route.zero? || routes_exist?(number_route)
        puts 'Маршрут с таким номером уже существует'
      else
        @routes << Route.new(@stations.find { |st| st.name == one_station },
                             @stations.find { |st| st.name == end_station },
                             number_route)
      end
      @routes.each.with_index(1) do |route, index|
        puts "Маршрут #{index} - первая станция #{route.first_station.name}, последняя станция #{route.last_station.name}"
      end
    end
  end

  def add_stations
    puts 'Введите название станции'
    name_station = gets.chomp
    puts 'Введите номер маршрута'
    number_route = gets.to_i
    if stations_exist?(name_station) && routes_exist?(number_route)
      @routes.each do |route|
        if route.number_route == number_route
          route.add_station(@stations.find { |st| st.name == name_station })
        end
      end
    else
      puts 'Убедитесь в существовании станции и маршрута'
    end
  end

  def set_rote_for_train
    puts 'Введите номер маршрута'
    number_route = gets.to_i
    puts 'Введите номер поезда'
    number_train = gets.to_i
    if routes_exist?(number_route) && trains_exist?(number_train)
      @trains.each do |train|
        next unless train.number == number_train

        train.route = (@routes.find do |route|
                         route.number_route == number_route
                       end)
      end
    else
      puts 'Убедитесь в существовании маршрута и поезда'
    end
    @trains.each { |train| puts "Поезду присвоен маршрут #{train.route.number_route}" if train.number == number_train }
  end

  def create_wagons
    loop do
      puts 'Введите номер вагона или пустую строку (просто нажмите Enter), чтобы выйти'
      number_wagons = gets.to_i
      if number_wagons.zero? || wagons_exist?(number_wagons)
        break if number_wagons.zero?

        puts 'Вагон с таким номером уже существует!'
        @wagons.each.with_index(1) { |wagons, index| puts "Вагон #{index} - #{wagons.number} тип вагона - " + wagons.type }
      else

        begin
          puts 'Выберите тип вагона'
          puts '1. Грузовой'
          puts '2. Пассажирский'
          a = gets.to_i
        end until a == 1 || a == 2
        @wagons << WagonsCargo.new(number_wagons) if a == 1
        @wagons << WagonsPassenger.new(number_wagons) if a == 2
        @wagons.each.with_index(1) { |wagons, index| puts "Вагон #{index} - #{wagons.number}, тип вагона - " + wagons.type }
      end
    end
  end
end

mn = Main.new
mn.create_stations
mn.create_trains
mn.create_routes
mn.create_wagons
mn.add_stations
mn.set_rote_for_train
