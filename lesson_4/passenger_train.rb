class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def add_wagon(wagons)
    @wagons << wagons if wagons.type == :passenger && !@wagons.include?(wagons) && @speed.zero?
  end

  def del_wagon(wagons)
    @wagons.delete(wagons) if @speed.zero? && !@wagons.empty?
  end
end
