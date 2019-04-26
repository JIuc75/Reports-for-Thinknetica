class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if first_station != station && last_station != station
      @stations.delete(station)
    end
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end
end
