require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagons'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'constants'

class Main
  def show_menu_create_station
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание станций'
    puts '2. Завершить создание станций'
  end

  def show_train_type_menu
    puts 'Выберите тип поезда'
    puts '1. Грузовой'
    puts '2. Пассажирский'
  end

  def show_menu_create_trains
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание поездов'
    puts '2. Завершить создание поездов'
  end

  def show_menu_create_routes
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание маршрутов'
    puts '2. Завершить создание маршрутов'
  end

  def show_add_stations_menu
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    puts '3. Выйти'
  end

  def show_menu_create_type_wagons
    puts DIVIDER
    puts 'Выберите тип вагона'
    puts '1. Грузовой'
    puts '2. Пассажирский'
  end

  def show_menu_create_wagons
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание вагонов'
    puts '2. Завершить создание вагонов'
  end

  def show_add_wagons_menu
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Прицепить вагон'
    puts '2. Отцепить вагон'
  end

  def show_menu_set_route
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить создание маршрутов'
    puts '2. Выйти'
  end

  def show_menu_send_train
    puts DIVIDER
    puts 'Куда вы хотите переместить поезд?'
    puts '1. Вперед'
    puts '2. Назад'
  end

  def show_menu_action_train
    puts DIVIDER
    puts 'Что вы хотите сделать?'
    puts '1. Продолжить управление поездами'
    puts '2. Завершить управление поездами'
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

  def manage_routes
    loop do
      show_menu_create_routes
      case gets.to_i
      when 1 then create_routes
      when 2 then run
      end
    end
  end

  def manage_stations
    loop do
      show_menu_create_station
      case gets.to_i
      when 1 then create_stations
      when 2 then run
      end
    end
  end

  def manage_trains
    loop do
      show_menu_create_trains
      case gets.to_i
      when 1 then create_trains
      when 2 then run
      end
    end
  end

  def manage_add_station
    loop do
      show_add_stations_menu
      case gets.to_i
      when 1 then add_stations
      when 2 then del_stations
      when 3 then run
      end
    end
  end

  def manage_set_route
    loop do
      case gets.to_i
      when 1 then set_route_for_train
      when 2 then run
      end
    end
  end

  def manage_create_wagons
    loop do
      show_menu_create_wagons
      case gets.to_i
      when 1 then create_wagons
      when 2 then run
      end
    end
  end

  def manage_add_wagons
    loop do
      show_add_wagons_menu
      case gets.to_i
      when 1 then add_wagons_to_train
      when 2 then run
      end
    end
  end

  def manage_action_train
    loop do
      show_menu_action_train
      case gets.to_i
      when 1 then send_train
      when 2 then run
      end
    end
  end

  def run
    show_menu
    case gets.to_i
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
      puts DIVIDER
      puts 'Выберите число, соответствующее списку'
      return run
    end
  end

  private # для предотвращения доступа к методам напрямую

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

  def create_stations
    puts DIVIDER
    puts 'Введите название станции'
    name_station = gets.chomp
    return if name_station.empty?

    if stations_exist?(name_station)
      puts STATION_ALREADY_EXIST
      return
    else
      @stations << Station.new(name_station)
    end
    all_station
    manage_stations
  end

  def create_trains
    puts DIVIDER
    puts 'Введите номер поезда'
    number_train = gets.chomp
    return if number_train.empty?

    if trains_exist?(number_train)
      puts TRAIN_ALREADY_EXIST
      return
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
    manage_trains
  end

  def create_routes
    puts DIVIDER
    puts 'Введите номер маршрут'
    all_route
    number_route = gets.chomp
    return if number_route.empty?

    puts 'Выберите начальную станцию из списка'
    all_station
    one_station = select_from_collect(@stations)
    return if one_station.nil?

    puts 'Выберите конечную станцию из списка'
    all_station
    end_station = select_from_collect(@stations)
    return if end_station.nil?

    if number_route.empty? || routes_exist?(number_route)
      puts ROUTE_ALREADY_EXIST
    else
      @routes << Route.new(one_station, end_station, number_route)
    end
    @routes.each.with_index(1) do |route, index|
      puts "Маршрут #{index} - первая станция #{route.first_station.name}, последняя станция #{route.last_station.name}"
    end
    manage_routes
  end

  def select_from_collect(collection)
    index = gets.to_i - 1
    return if index.negative?

    collection[index]
  end

  def add_stations
    puts 'Выберите маршрут из списка'
    all_route
    route = select_from_collect(@routes)
    return if route.nil?

    puts 'Выберите станцию из списка'
    all_station
    station = select_from_collect(@stations)
    return if station.nil?

    if stations_exist?(station) && routes_exist?(route)
      show_add_stations_menu |
        route.add_station(station)
    else
      puts ROUTE_AND_STATION_ALREADY_EXIST
    end
    manage_add_station
  end

  def del_stations
    puts DIVIDER
    puts 'Выберите маршрут из списка'
    all_route
    route = select_from_collect(@routes)
    return if route.nil?

    puts 'Выберите станцию из списка'
    all_station
    station = select_from_collect(@stations)
    return if station.nil?

    if stations_exist?(station) && routes_exist?(route)
      show_add_stations_menu
      @routes.each do |train|
        train.add_station(station)
      end
    else
      puts ROUTE_AND_STATION_ALREADY_EXIST
    end
    manage_add_station
  end

  def set_route_for_train
    puts DIVIDER
    puts 'Выберите номер маршрута'
    all_route
    number_route = select_from_collect(@routes)
    return if number_route.nil?

    puts 'Введите номер поезда'
    all_train
    number_train = select_from_collect(@trains)
    return if number_train.nil?

    if routes_exist?(number_route) && trains_exist?(number_train)
      @trains.each do |train|
        next unless train.number == number_train

        train.route = number_route
      end
    else
      puts ROUTE_AND_TRAIN_ALREADY_EXIST
    end
    @trains.each { |train| puts "Поезду присвоен маршрут #{train.route.number_route}" }
    manage_set_route
  end

  def create_wagons
    puts DIVIDER
    puts 'Введите вагон из списка'
    all_wagon
    number_wagons = select_from_collect(@wagons)
    if number_wagons.nil? || wagons_exist?(number_wagons)
      return if number_wagons.nil?

      puts WAGONS_ALREADY_EXIST
    else
      show_menu_create_type_wagons
      case gets.to_i
      when 1 then @wagons << CargoWagon.new(number_wagons)
      when 2 then @wagons << PassengerWagon.new(number_wagons)
      else
        puts DIVIDER
        puts 'Выберите 1 или 2'
      end
      @wagons.each.with_index(1) do |wagons, index|
        puts "Вагон #{index} - #{wagons.number}, тип вагона - " + wagons.type
      end
    end
    manage_create_wagons
  end

  def add_wagons_to_train
    puts DIVIDER
    puts 'Выберите вагон из списка'
    all_wagon
    wagons = select_from_collect(@wagons)
    return if wagons.nil?

    puts 'Выберите поезд из списка'
    all_train
    train = select_from_collect(@trains)
    return if train.nil?

    if wagons_exist?(wagons) && trains_exist?(train)
      train.add_wagon(wagons)
    else
      puts WAGONS_AND_TRAIN_ALREADY_EXIST
      return
    end
    manage_add_wagons
  end

  def del_wagons_to_train
    puts DIVIDER
    puts 'Выберите вагон из списка'
    all_wagon
    wagons = select_from_collect(@wagons)
    return if wagons.nil?

    puts 'Выберите поезд из списка'
    all_train
    train = select_from_collect(@trains)
    return if train.nil?

    if wagons_exist?(wagons) && trains_exist?(train)
      show_add_wagons_menu
      train.del_wagon(wagons)
    else
      puts WAGONS_AND_TRAIN_ALREADY_EXIST
    end
    manage_add_wagons
  end

  def send_train
    puts DIVIDER
    puts 'Выберите поезд'
    all_train
    train = select_from_collect(@trains)
    if trains_exist?(train)
      show_menu_send_train
      case gets.to_i
      when 1 then train.forward
      when 2 then train.backward
      else
        puts 'Выберите 1 или 2'
      end
    else
      puts TRAIN_NUMBER_ALREADY_EXIST
      return
    end
    manage_action_train
  end

  def show_trains_on_station
    puts DIVIDER
    puts 'Выберите станцию из списка'
    all_station
    station = select_from_collect(@stations)
    if stations_exist?(station)
      puts "На станции \"#{station}\" находятся поезда:"
      station.trains.each.with_index(1) { |train, index| puts "#{index}. Поезд - №#{train.number}" }
    else
      puts DIVIDER
      puts 'Такой станции не существует'
    end
  end

  def all_station
    @stations.each.with_index(1) { |station, index| puts "Станция № #{index} - #{station.name}" }
  end

  def all_route
    @routes.each.with_index(1) { |route, index| puts "Маршрут № #{index} - #{route.number_route}" }
  end

  def all_train
    @trains.each.with_index(1) { |train, index| puts "Поезд № #{index} - #{train.number}" }
  end

  def all_wagon
    @wagons.each.with_index(1) { |wagon, index| puts "Поезд № #{index} - #{wagon.number}" }
  end
end

mn = Main.new
mn.run
