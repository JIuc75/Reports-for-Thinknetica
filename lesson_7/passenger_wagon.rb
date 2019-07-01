class PassengerWagon < Wagon

  alias take_the_place_of take_volume

  def initialize(number)
    super(number, 'passenger')
  end

  def take_the_place_of
    take_volume(1)
  end

  def take_volume(volume = 1)
    super(1)
  end

end
