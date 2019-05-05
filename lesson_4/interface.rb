class Interface
  def initialize
    @main = Main.new
  end

  def create_object
    show_menu
    a = gets.to_i
    case a
    when 1
      @main.create_stations
    when 2
      @main.create_trains
    when 3
      @main.create_routes
    when 4
      @main.create_wagons
    when 5
      @main.add_and_del_stations
    when 6
      @main.set_route_for_train
    when 7
      @main.add_and_del_wagons_to_train
    when 8
      @main.send_tarins
    when 9
      @main.all_station
    when 10
      @main.show_trains_on_station
    when 11
      exit
    else
      puts 'Выберите число, соответствующее списку'
    end
  end
end



