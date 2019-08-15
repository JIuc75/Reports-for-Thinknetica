require_relative 'instance_counter'
require_relative 'validations'
require_relative 'acсessors'

class Route
  include InstanceCounter
  include Validations

  INCORRECT_START_ST  = 'Неверный тип начальной станции'.freeze
  INCORRECT_FINISH_ST = 'Неверный тип конечной станции'.freeze
  SAME_STATIONS = 'Начальные и конечные станции не должны совпадать'.freeze

  attr_reader :start_station, :end_station, :stations, :number

  attr_accessor_with_history :stations, :start_station, :end_station

  validate :from, :presence
  validate :to, :presence
  validate :from, :type, Station
  validate :to, :type, Station

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
