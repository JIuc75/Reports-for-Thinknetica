class PassengerTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER
  validate :type, :presence

  def initialize(number)
    super(number, 'passenger')
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end
