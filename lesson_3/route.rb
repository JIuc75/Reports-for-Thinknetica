class Route
  attr_reader :start_station, :end_station, :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
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
end
