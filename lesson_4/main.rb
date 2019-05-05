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

  def create_stations
    loop do
      puts 'Введите название станции или пустую строку (просто нажмите Enter), чтобы выйти'
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
      puts 'Введите № поезда и тип или пустую строку (просто нажмите Enter), чтобы выйти'
      number_train = gets.to_i
      break if number_train.zero?

      if number_train.zero? || trains_exist?(number_train)
        puts 'Поезд таким номером уже существует!'
      else
        begin
          puts 'Выберите тип поезда'
          puts '1. Грузовой'
          puts '2. Пассажирский'
          a = gets.to_i
        end until a == 1 || a == 2
        @trains << CargoTrain.new(number_train) if a == 1
        @trains << PassengerTrain.new(number_train) if a == 2
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

  def add_and_del_stations
    loop do
      puts 'Введите номер маршрута или пустую строку (просто нажмите Enter), чтобы выйти'
      number_route = gets.to_i
      puts 'Введите название станции'
      name_station = gets.chomp
      break if number_route.zero?

      if stations_exist?(name_station) && routes_exist?(number_route)
        begin
          puts 'Что вы хотите сделать?'
          puts '1. Прицепить вагон'
          puts '2. Отцепить вагон'
          a = gets.to_i
        end until a == 1 || a == 2
        @routes.each do |train|
          train.add_station(@stations.find { |st| st.name == name_station }) if train.number == number_route && a == 1
        end
        @routes.each do |train|
          train.delete_station(@wagons.find { |st| st.name == name_station }) if train.number == number_route && a == 2
        end
      else
        puts 'Убедитесь в существовании станции и маршрута'
      end
    end
  end

  def set_route_for_train
    loop do
      puts 'Введите номер маршрута или пустую строку (просто нажмите Enter), чтобы выйти'
      number_route = gets.to_i
      break if number_route.zero?

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

  def add_and_del_wagons_to_train
    puts 'Введите номер вагона'
    number_wagons = gets.to_i
    puts 'Введите номер поезда'
    number_train = gets.to_i
    if wagons_exist?(number_wagons) && trains_exist?(number_train)
      begin
        puts 'Что вы хотите сделать?'
        puts '1. Прицепить вагон'
        puts '2. Отцепить вагон'
        a = gets.to_i
      end until a == 1 || a == 2
      @trains.each do |train|
        train.add_wagon(@wagons.find { |wagons| wagons.number == number_wagons }) if train.number == number_train && a == 1
      end
      @trains.each do |train|
        train.del_wagon(@wagons.find { |wagons| wagons.number == number_wagons }) if train.number == number_train && a == 2
      end
    else
      puts 'Убедитесь в существовании вагона и поезда'
    end
  end

  def send_tarins
    puts 'Введите номер поезда'
    number_train = gets.to_i
    if trains_exist?(number_train)
      begin
        puts 'Куда вы хотите переместить?'
        puts '1. Вперед'
        puts '2. Назад'
        a = gets.to_i
      end until a == 1 || a == 2
      @trains.each { |train| train.forward if train.number == number_train } if a == 1
      @trains.each { |train| train.backward if train.number == number_train } if a == 2
    else
      puts 'Поезда с таким номером не существует!'
    end
  end
end

def show_trains_on_station
  puts 'Введите название станции'
  name_station = gets.chomp
  if stations_exist?(name_station)
    puts "На станции \"#{name_station}\" находятся поезда:"
    @stations.each { |station| station.trains.each.with_index(1) { |train, index| puts "#{index}. Поезд - №#{train.number}" } if station.name == name_station }
  else
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
  puts '5. Добавить/Удалить станцию в/из маршрут(а)'
  puts '6. Назначить маршрут поезду'
  puts '7. Прицепить/Отцепить вагон к/от поезду(а)'
  puts '8. Переместить поезд по маршруту'
  puts '9. Показать все станции'
  puts '10. Показать все поезда на станции'
  puts '11. Выход'
end

