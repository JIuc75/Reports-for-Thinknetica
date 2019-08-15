class CargoTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER
  validate :type, :presence

  def initialize(number)
    super(number, 'cargo')
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end
end
