require_relative 'instance_counter'
require_relative 'validations'

class Route
  include InstanceCounter
  include Validations

  attr_reader :start_station, :end_station, :stations, :number

  def initialize(start_station, end_station, number)
    @stations = [start_station, end_station]
    @number = number
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if [first_station, last_station].include?(station)

    @stations.delete(station)
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  protected

  def validate!
    raise INCORRECT_START_ST unless stations[0].is_a?(Station)
    raise INCORRECT_FINISH_ST unless stations[-1].is_a?(Station)
    raise SAME_STATIONS if stations[0] == stations[-1]
  end

end
