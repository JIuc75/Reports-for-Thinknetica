class PassengerWagon < Wagon

  def initialize(number, volume)
    super(number, volume, 'passenger')
  end

  def take_volume(volume = 1)
    super(1)
  end

  alias take_the_place take_volume

end
