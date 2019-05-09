class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end

  def add_wagon(wagons)
    @wagons << wagons if wagons.type == :cargo && !@wagons.include?(wagons) && @speed.zero?
  end

  def del_wagon(wagons)
    @wagons.delete(wagons) if @speed.zero? && !@wagons.empty?
  end
end
