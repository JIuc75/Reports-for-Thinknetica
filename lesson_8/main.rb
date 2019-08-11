require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'interface_constants'
require_relative 'manufacture'

class Main
  include InterfaceConstants
  include Manufacture

  def run
    loop do
      show_menu
      case gets.to_i
      when 1 then create_stations
      when 2 then create_trains
      when 3 then create_route
      when 4 then create_wagon
      when 5 then add_stations
      when 6 then del_stations
      when 7 then set_route_for_train
      when 8 then add_wagons_to_train
      when 9 then del_wagons_to_train
      when 10 then send_train
      when 11 then show_stations(@stations)
      when 12 then show_trains_on_station
      when 13 then show_wagons(@wagons)
      else
        puts DIVIDER
        puts 'Выберите число, соответствующее списку'
      end
    end
  end

  private

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
    show_stations(@stations)
  end

  def create_trains
    puts DIVIDER
    puts 'Введите номер поезда'
    number_train = gets.chomp
    return if number_train.empty?

    puts 'Введите производителя'
    name = gets.chomp
    self.manufacture = name

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
    show_trains(@trains)
  rescue RuntimeError => e
    puts DIVIDER
    puts e.message
    retry
  end

  def create_route
    puts DIVIDER
    puts 'Введите номер маршрут'
    show_routes(@routes)
    number_route = gets.chomp
    return if number_route.empty?

    puts 'Выберите начальную станцию из списка'
    show_stations(@stations)
    one_station = select_from_collection(@stations)
    return if one_station.nil?

    puts 'Выберите конечную станцию из списка'
    show_stations(@stations)
    end_station = select_from_collection(@stations)
    return if end_station.nil?

    if number_route.empty?
      puts ROUTE_ALREADY_EXIST
    else
      @routes << Route.new(one_station, end_station, number_route)
      show_routes(@routes)
    end
  end

  def select_from_collection(collection)
    index = gets.to_i - 1
    return if index.negative?

    collection[index]
  end

  def add_stations
    puts 'Выберите маршрут из списка'
    show_routes(@routes)
    route = select_from_collection(@routes)
    return if route.nil?

    puts 'Выберите станцию из списка'
    show_stations(@stations)
    station = select_from_collection(stations)
    return if station.nil?

    route.add_station(station)
  end

  def del_stations
    puts DIVIDER
    puts 'Выберите маршрут из списка'
    show_routes(@routes)
    route = select_from_collection(@routes)
    return if route.nil?

    puts 'Выберите станцию из списка'
    show_stations(route.stations)
    station = select_from_collection(route.stations)
    return if station.nil?

    route.delete_station(station)
  end

  def set_route_for_train
    puts DIVIDER
    puts 'Выберите номер маршрута'
    show_routes(@routes)
    route = select_from_collection(@routes)
    return if route.nil?

    puts 'Введите номер поезда'
    show_trains(@trains)
    train = select_from_collection(@trains)
    return if train.nil?

    train.route = route
  end

  def create_wagon
    puts DIVIDER
    puts 'Введите № вагона'
    show_wagons(@wagons)
    number_wagons = gets.chomp
    if number_wagons.empty? || wagons_exist?(number_wagons)
      puts WAGONS_ALREADY_EXIST
      return
    else
      show_menu_create_type_wagons
      case gets.to_i
      when 1 then
        puts 'Укажите обьем в вагоне'
        volume = gets.chomp
        @wagons << CargoWagon.new(number_wagons, volume)
      when 2 then
        puts 'Укажите количество мест в вагоне'
        number_of_seats = gets.chomp
        @wagons << PassengerWagon.new(number_wagons, number_of_seats)
      else
        puts DIVIDER
        puts 'Выберите 1 или 2'
      end
    end
    puts 'Введите производителя'
    name = gets.chomp
    self.manufacture = name
    show_wagons(@wagons)
  end

  def add_wagons_to_train
    puts DIVIDER
    puts 'Выберите вагон из списка'
    show_wagons(@wagons)
    wagon = select_from_collection(@wagons)
    return if wagon.nil?

    puts 'Выберите поезд из списка'
    show_trains(@trains)
    train = select_from_collection(@trains)
    return if train.nil?

    train.add_wagon(wagon)
  end

  def del_wagons_to_train
    puts DIVIDER
    puts 'Выберите поезд из списка'
    show_trains(@trains)
    train = select_from_collection(@trains)
    return if train.nil?

    puts 'Выберите вагон из списка'
    show_wagons(train.wagons)
    wagon = select_from_collection(train.wagons)
    return if wagon.nil?

    train.del_wagon(wagon)
  end

  def send_train
    puts DIVIDER
    puts 'Выберите поезд'
    show_trains(@trains)
    train = select_from_collection(@trains)
    show_menu_send_train
    case gets.to_i
    when 1 then train.forward
    when 2 then train.backward
    else
      puts 'Выберите 1 или 2'
    end
  end

  def show_trains_on_station
    puts DIVIDER
    puts 'Выберите станцию из списка'
    show_stations(@stations)
    station = select_from_collection(@stations)
    return if station.nil?

    puts "На станции #{station} находятся поезда:"
    station.trains.each.with_index(1) { |train, index| puts "#{index}. Поезд - № #{train.number}" }
  end

  def show_stations(stations)
    stations.each.with_index(1) do |station, index|
      puts "Станция № \"#{index}\" - #{station.name}"
    end
  end

  def show_routes(routes)
    routes.each.with_index(1) do |route, index|
      puts "Маршрут № \"#{index}\" - #{route.number}"
    end
  end

  def show_trains(trains)
    trains.each.with_index(1) do |train, index|
      puts "Поезд № \"#{index}\" - #{train.number} #{manufacture}"
    end
  end

  def show_wagons(wagons)
    wagons.each.with_index do |wagon, index|
      if wagon.type == 'cargo'
        puts "#{index} - номер: #{wagon.number}, тип: #{wagon.type}"
        puts " общий объем грузового вагона #{wagon.volume}"
        puts " занятый объем #{wagon.occupies_volume}"
      elsif wagon.type == 'passenger'
        puts "#{index} - номер: #{wagon.number}, тип: #{wagon.type}"
        puts " кол-во совободных мест #{wagon.vacancies}"
        puts " кол-во занятых мест #{wagon.occupied_places}"
      end
    end
  end

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
      when 1 then create_route
      when 2 then break
      end
    end
  end

  def manage_stations
    loop do
      show_menu_create_station
      case gets.to_i
      when 1 then create_stations
      when 2 then break
      end
    end
  end

  def manage_trains
    loop do
      show_menu_create_trains
      case gets.to_i
      when 1 then create_trains
      when 2 then break
      end
    end
  end

  def manage_add_station
    loop do
      show_add_stations_menu
      case gets.to_i
      when 1 then add_stations
      when 2 then del_stations
      when 3 then break
      end
    end
  end

  def manage_set_route
    loop do
      case gets.to_i
      when 1 then set_route_for_train
      when 2 then break
      end
    end
  end

  def manage_create_wagons
    loop do
      show_menu_create_wagons
      case gets.to_i
      when 1 then create_wagon
      when 2 then break
      end
    end
  end

  def manage_add_wagons
    loop do
      show_add_wagons_menu
      case gets.to_i
      when 1 then add_wagons_to_train
      when 2 then break
      end
    end
  end

  def manage_action_train
    loop do
      show_menu_action_train
      case gets.to_i
      when 1 then send_train
      when 2 then break
      end
    end
  end
end

mn = Main.new
mn.run
