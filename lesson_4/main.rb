require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'cargo_tarin'
require_relative 'passenger_train'
require_relative 'wagons'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'
require_relative 'constants'

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
    @wagons.find { |wagons| wagons.number == number_wagons }
  end

  def show_menu_create_station
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание станций'
    puts '2. Завершить создание станций'
    case gets.to_i
    when 1 then create_stations
    when 2 then run
    else
      puts '---------------------------------'
      puts 'Введите 1 или 2'
      return show_menu_create_station
    end
  end

  def create_stations
    puts '---------------------------------'
    puts 'Введите название станции'
    name_station = gets.chomp
    run if name_station.empty?
    if stations_exist?(name_station)
      puts STATION_ALREADY_EXIST
      return create_stations
    else
      @stations << Station.new(name_station)
    end
    @stations.each.with_index(1) do |station, index|
      puts "Cтанция #{index} - #{station.name}"
    end
    show_menu_create_station
  end

  def show_train_type_menu
    puts 'Выберите тип поезда'
    puts '1. Грузовой'
    puts '2. Пассажирский'
  end

  def show_menu_create_trains
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание поездов'
    puts '2. Завершить создание поездов'
    case gets.to_i
    when 1 then create_trains
    when 2 then run
    else
      puts '---------------------------------'
      puts 'Введите 1 или 2'
      return show_menu_create_trains
    end
  end

  def create_trains
    puts '---------------------------------'
    puts 'Введите номер поезда'
    number_train = gets.chomp
    return create_trains if number_train.empty?

    if trains_exist?(number_train)
      puts TRAIN_ALREADY_EXIST
      return create_trains
    end
    show_train_type_menu
    case gets.to_i
    when 1 then @trains << CargoTrain.new(number_train)
    when 2 then @trains << PassengerTrain.new(number_train)
    else
      puts 'Выберите 1 или 2'
    end
    @trains.each.with_index(1) do |train, index|
      puts "Поезд #{index} - \"№ #{train.number}\" - \"#{train.type}\""
    end
    show_menu_create_trains
  end

  def show_menu_create_routes
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание маршрутов'
    puts '2. Завершить создание маршрутов'
    case gets.to_i
    when 1 then create_routes
    when 2 then run
    else
      puts '---------------------------------'
      puts 'Введите 1 или 2'
      return show_menu_create_routes
    end
  end

  def create_routes
    puts '---------------------------------'
    puts 'Введите номер маршрута'
    number_route = gets.chomp
    return create_routes if number_route.empty?

    puts 'Введите название первой станции'
    one_station = gets.chomp
    puts 'Введите название последней станции'
    end_station = gets.chomp
    if number_route.empty? || routes_exist?(number_route)
      puts ROUTE_ALREADY_EXIST
    else
      @routes << Route.new(@stations.find { |st| st.name == one_station },
                           @stations.find { |st| st.name == end_station },
                           number_route)
    end
    @routes.each.with_index(1) do |route, index|
      puts "Маршрут #{index} - первая станция #{route.first_station.name}, последняя станция #{route.last_station.name}"
    end
    show_menu_create_routes
  end

  def show_add_stations_menu
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    puts '3. Выйти'
    case gets.to_i
    when 1 then add_stations
    when 2 then del_stations
    else
      puts 'Выберите 1, 2  или 3'
      return show_add_stations_menu
    end
  end

  def add_stations
    puts 'Введите номер маршрута или пустую строку (просто нажмите Enter), чтобы выйти'
    number_route = gets.chomp
    puts 'Введите название станции'
    name_station = gets.chomp
    return add_stations if number_route.empty?

    if stations_exist?(name_station) && routes_exist?(number_route)
      show_add_stations_menu
      @routes.each do |train|
        train.add_station(@stations.find { |st| st.name == name_station }) if train.number == number_route
      end
    else
      puts ROUTE_AND_STATION_ALREADY_EXIST
    end
    show_add_stations_menu
  end

  def del_stations
    puts 'Введите номер маршрута или введите 1 чтобы выйти'
    number_route = gets.chomp
    puts 'Введите название станции'
    name_station = gets.chomp
    return del_stations if number_route.empty?

    if stations_exist?(name_station) && routes_exist?(number_route)
      show_add_stations_menu
      @routes.each do |train|
        train.add_station(@stations.find { |st| st.name == name_station }) if train.number == number_route
      end
    else
      puts ROUTE_AND_STATION_ALREADY_EXIST
    end
  end

  def show_menu_set_route
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание маршрутов'
    puts '2. Выйти'
    case gets.to_i
    when 1 then set_route_for_train
    when 2 then run
    else
      puts 'Выберите 1 или 2'
      return show_menu_set_route
    end
  end

  def set_route_for_train
    puts '---------------------------------'
    puts 'Введите номер маршрута'
    number_route = gets.chomp
    return set_route_for_train if number_route.empty?

    puts 'Введите номер поезда'
    number_train = gets.chomp
    if routes_exist?(number_route) && trains_exist?(number_train)
      @trains.each do |train|
        next unless train.number == number_train

        train.route = (@routes.find do |route|
                         route.number_route == number_route
                       end)
      end
    else
      puts ROUTE_AND_TRAIN_ALREADY_EXIST
    end
    @trains.each { |train| puts "Поезду присвоен маршрут #{train.route.number_route}" if train.number == number_train }
    show_menu_set_route
  end

  def show_menu_create_type_wagons
    puts '---------------------------------'
    puts 'Выберите тип вагона'
    puts '1. Грузовой'
    puts '2. Пассажирский'
  end

  def show_menu_create_wagons
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание вагонов'
    puts '2. Завершить создание вагонов'
    case gets.to_i
    when 1 then create_wagons
    when 2 then run
    else
      puts '---------------------------------'
      puts 'Выберите 1 или 2'
      return show_menu_create_wagons
    end
  end

  def create_wagons
    puts '---------------------------------'
    puts 'Введите номер вагона'
    number_wagons = gets.chomp
    if number_wagons.zero? || wagons_exist?(number_wagons)
      return create_wagons if number_wagons.empty?

      puts WAGONS_ALREADY_EXIST
      @wagons.each.with_index(1) { |wagons, index| puts "Вагон #{index} - #{wagons.number} тип вагона - " + wagons.type }
    else
      show_menu_create_type_wagons
      case gets.to_i
      when 1 then @wagons << WagonsCargo.new(number_wagons)
      when 2 then @wagons << WagonsPassenger.new(number_wagons)
      @wagons.each.with_index(1) { |wagons, index| puts "Вагон #{index} - #{wagons.number}, тип вагона - " + wagons.type }
      else
        puts '---------------------------------'
        puts 'Выберите 1 или 2'
      end
    end
    show_menu_create_wagons
  end

  def show_add_wagons_menu
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Прицепить вагон'
    puts '2. Отцепить вагон'
    case gets.to_i
    when 1 then add_wagons_to_train
    when 2 then del_wagons_to_train
    else
      puts '---------------------------------'
      puts 'Выберите 1 или 2'
    end
  end

  def add_wagons_to_train
    puts '---------------------------------'
    puts 'Введите номер вагона'
    number_wagons = gets.chomp
    puts 'Введите номер поезда'
    number_train = gets.chomp
    if wagons_exist?(number_wagons) && trains_exist?(number_train)
      @trains.each do |train|
        train.add_wagon(@wagons.find { |wagons| wagons.number == number_wagons }) if train.number == number_train
      end
      @wagons.each.with_index(1) { |wagons, index| puts "Вагон #{index} - #{wagons.number}, тип вагона - " + wagons.type }
    else
      puts WAGONS_AND_TRAIN_ALREADY_EXIST
    end
  end

  def del_wagons_to_train
    puts '---------------------------------'
    puts 'Введите номер вагона'
    number_wagons = gets.to_i
    puts '---------------------------------'
    puts 'Введите номер поезда'
    number_train = gets.to_i
    if wagons_exist?(number_wagons) && trains_exist?(number_train)
      show_add_wagons_menu
      @trains.each do |train|
        train.del_wagon(@wagons.find { |wagons| wagons.number == number_wagons }) if train.number == number_train
      end
    else
      puts WAGONS_AND_TRAIN_ALREADY_EXIST
    end
  end

  def show_menu_send_train
    puts '---------------------------------'
    puts 'Куда вы хотите переместить поезд?'
    puts '1. Вперед'
    puts '2. Назад'
  end

  def show_menu_action_train
    puts '---------------------------------'
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить управление поездами'
    puts '2. Завершить управление поездами'
    case gets.to_i
    when 1 then send_train
    when 2 then run
    else
      puts '---------------------------------'
      puts 'Выберите 1 или 2'
      return show_menu_action_train
    end
  end

  def send_train
    puts '---------------------------------'
    puts 'Введите номер поезда'
    number_train = gets.chomp
    if trains_exist?(number_train)
      show_menu_send_train
      case gets.to_i
      when 1 then @trains.each { |train| train.forward if train.number == number_train }
      when 2 then @trains.each { |train| train.backward if train.number == number_train }
      else
        puts 'Выберите 1 или 2'
      end
    else
      puts TRAIN_NUMBER_ALREADY_EXIST
    end
    show_menu_action_train
  end

  def show_trains_on_station
    puts '---------------------------------'
    puts 'Введите название станции'
    name_station = gets.chomp
    if stations_exist?(name_station)
      puts "На станции \"#{name_station}\" находятся поезда:"
      @stations.each { |station| station.trains.each.with_index(1) { |train, index| puts "#{index}. Поезд - №#{train.number}" } if station.name == name_station }
    else
      puts '---------------------------------'
      puts 'Такой станции не существует'
    end
  end

  def all_station
    @stations.each.with_index(1) { |station, index| puts "Станция № #{index} - #{station.name}" }
  end

  def show_menu
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Создать вагон'
    puts '5. Добавить станцию в маршрут'
    puts '6. Удалить станцию из маршрута'
    puts '7. Назначить маршрут поезду'
    puts '8. Прицепить вагон к поезду'
    puts '9. Отцепить вагон от поезда'
    puts '10. Переместить поезд по маршруту'
    puts '11. Показать все станции'
    puts '12. Показать все поезда на станции'
    puts '13. Выход'
  end

  def run
    show_menu
    a = gets.to_i
    case a
    when 1 then create_stations
    when 2 then create_trains
    when 3 then create_routes
    when 4 then create_wagons
    when 5 then add_stations
    when 6 then del_stations
    when 7 then set_route_for_train
    when 8 then add_wagons_to_train
    when 9 then del_wagons_to_train
    when 10 then send_train
    when 11 then all_station
    when 12 then show_trains_on_station
    when 13 then exit
    else
      puts '---------------------------------'
      puts 'Выберите число, соответствующее списку'
      return run
    end
  end
end

mn = Main.new
mn.run
